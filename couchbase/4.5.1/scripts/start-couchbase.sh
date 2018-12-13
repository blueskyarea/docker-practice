#!/bin/bash

ulimit -l unlimited
ulimit -n 10240 
ulimit -c unlimited
sudo /etc/init.d/couchbase-server start

function retryRequest () {
  count=0
  retry_upper_limit=5
  request=$1
  while :
  do
    command="curl -L ${request} -o /dev/null -w %{http_code}\n -s"
    res=$(${command})
    if [ $res = 200 ] || [ $res = 202 ] ; then
      break
    fi
    count=$(expr $count + 1)
    if [ ${count} -gt ${retry_upper_limit} ] ; then
      exit -1
    fi
    sleep 5s
  done
}

function retryCommand () {
  count=0
  retry_upper_limit=5
  cmd=$1
  while :
  do
    ${cmd}
    res=$?
    if [ $res != 0 ] ; then
      break
    fi
    count=$(expr $count + 1)
    if [ ${count} -gt ${retry_upper_limit} ] ; then
      exit -1
    fi
    sleep 5s
  done
}

# waiting for finishing to start couchbase-server
retryRequest "http://localhost:8091"

# Setup Administrator username and password
retryRequest "-X POST http://localhost:8091/settings/web -d password=password&username=admin&port=8091"

# Setup Bucket
retryRequest "-u admin:password -v -X POST http://localhost:8091/pools/default/buckets -d flushEnabled=1&threadsNumber=3&replicaIndex=0&replicaNumber=0&evictionPolicy=valueOnly&ramQuotaMB=597&bucketType=membase&name=default&authType=sasl&saslPassword="

# Setup Index RAM Quota
retryRequest "-u admin:password -v -X POST http://localhost:8091/pools/default -d memoryQuota=2000&indexMemoryQuota=269"

# Setup cluster
if [ "${TAG}" = 'PRI' ]; then
  retryCommand "/opt/couchbase/bin/couchbase-cli rebalance -c 172.26.0.1:8091 -u admin -p password --server-add=172.26.0.2:8091 --server-add-username=admin --server-add-password=password"
  retryCommand "/opt/couchbase/bin/couchbase-cli rebalance -c 172.26.0.1:8091 -u admin -p password --server-add=172.26.0.3:8091 --server-add-username=admin --server-add-password=password"
fi
