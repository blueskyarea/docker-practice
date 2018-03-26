#!/bin/bash
set -e

if [ "$TAG" = 'RM' ]; then
  exec /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start resourcemanager &
  rm -rf /tmp/hadoop-root/dfs/data/current &
  exec /usr/hdp/2.6.2.0-205/hadoop/bin/hdfs --config /etc/hadoop/conf namenode -format -f &
  exec /usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start namenode &
  while true; do sleep 1000; done
elif [ "$TAG" = 'NM' ]; then
  exec /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start nodemanager &
  while true; do sleep 1000; done
fi

