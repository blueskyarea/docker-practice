#!/bin/bash
set -e

function waitClusterStart() {
  while :
  do
    res=$(curl -L 'http://container-hdp-rm1001:8088/ws/v1/cluster/metrics' -s)
    check=`echo "$res" | sed 's/,/\n/g' | sed 's/}//g' | grep activeNodes | awk -F':' '{print $2}'`
    if [ $check -gt 0 ] ; then
      break
    fi
    echo "waiting to start cluster."
    sleep 10s
  done
}

if [ "$TAG" = 'RM' ]; then
  /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start resourcemanager &&
  rm -rf /tmp/hadoop-root/dfs/data/current &&
  echo "Y" | /usr/hdp/2.6.2.0-205/hadoop/bin/hdfs --config /etc/hadoop/conf namenode -format &&
  /usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start namenode &&
  sleep 60 &&
  /bin/bash /hdfs-setup.sh &&
  while true; do sleep 1000; done 
elif [ "$TAG" = 'NM' ]; then
  rm -rf /grid/hadoop/hdfs/dn/* &&
  sleep 30 &&
  /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start nodemanager &&
  /usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start datanode &&
  /bin/bash /start-zookeeper.sh &&
  while true; do sleep 1000; done
elif [ "$TAG" = 'HMASTER' ]; then
  waitClusterStart &&
  /bin/bash /start-zookeeper.sh &&
  /bin/bash /start-hbase.sh &&
  while true; do sleep 1000; done
elif [ "$TAG" = 'HUE' ]; then
  waitClusterStart &&
  /bin/bash /etc/init.d/hue start &&
  while true; do sleep 1000; done
else
  while true; do sleep 1000; done
fi

