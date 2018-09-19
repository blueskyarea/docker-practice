#!/bin/bash

ulimit -l unlimited
ulimit -n 10240 
ulimit -c unlimited
sudo /etc/init.d/couchbase-server start

# TODO wait for finishing to start couchbase-server
sleep 30s

# Setup Administrator username and password
curl -v -X POST http://localhost:8091/settings/web -d 'password=password&username=admin&port=8091'

# Setup Bucket
curl -u admin:password -v -X POST http://localhost:8091/pools/default/buckets \
-d 'flushEnabled=1&threadsNumber=3&replicaIndex=0&replicaNumber=0&evictionPolicy=valueOnly&ramQuotaMB=597&bucketType=membase&name=default&authType=sasl&saslPassword='

# Setup Index RAM Quota
curl -u admin:password -X POST http://localhost:8091/pools/default \
-d 'memoryQuota=5000' -d 'indexMemoryQuota=269'

