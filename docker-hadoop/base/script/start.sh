#!/bin/bash
set -e

/etc/init.d/ssh start
if [ "${TAG}" = 'HSLAVE' ]; then
  echo "Nothing to do"
  while true; do sleep 1000; done 
fi

if [ "${TAG}" = 'HMASTER' ]; then
  echo "start-hdfs" &&
  rm -rf /hadoop-data/dfs/* &&
  ${HADOOP_HOME}/bin/hadoop namenode -format &&
  ${HADOOP_HOME}/sbin/start-dfs.sh
  echo "start-yarn" &&
  ${HADOOP_HOME}/sbin/start-yarn.sh
  while true; do sleep 1000; done 
fi
