#!/bin/bash
set -e

if [ "$TAG" = 'RM' ]; then
  /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start resourcemanager &&
  rm -rf /tmp/hadoop-root/dfs/data/current &&
  echo "Y" | /usr/hdp/2.6.2.0-205/hadoop/bin/hdfs --config /etc/hadoop/conf namenode -format &&
  /usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start namenode &&
  #hdfs dfs -mkdir /user &&
  while true; do sleep 1000; done 
elif [ "$TAG" = 'NM' ]; then
  /usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start nodemanager &&
  /usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start datanode &&
  #hdfs dfs -mkdir /user &&
  while true; do sleep 1000; done
fi

