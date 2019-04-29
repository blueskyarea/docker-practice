#!/bin/bash
set -e

if [ "${TAG}" = 'MASTER' ]; then
  /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start resourcemanager &&
  rm -rf /tmp/hadoop-root/dfs/data/current &&
  echo "Y" | /usr/hdp/2.6.2.0-205/hadoop/bin/hdfs --config /etc/hadoop/conf namenode -format &&
  /usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start namenode &&
  while true; do sleep 1000; done
elif [ "${TAG}" = 'WORKER' ]; then
  rm -rf /grid/hadoop/hdfs/dn/* &&
  sleep 30 &&
  /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start nodemanager &&
  /usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start datanode &&
  while true; do sleep 1000; done
fi

