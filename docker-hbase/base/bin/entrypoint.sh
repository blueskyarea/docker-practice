#!/usr/bin/env bash

set -euox pipefail

export HBASE_HOME="/hbase"
export JAVA_HOME="${JAVA_HOME:-/usr}"

echo "================================================================================"
echo "                              HBase Docker Container"
echo "================================================================================"
echo
mkdir -pv "$HBASE_HOME/logs"

start_zookeeper(){
  echo "Starting Zookeeper..."
  "${HBASE_HOME}/bin/hbase" zookeeper &>"${HBASE_HOME}/logs/zookeeper.log" &
  echo
}

start_master(){
  echo "Starting HBase Master..."
  "${HBASE_HOME}/bin/hbase-daemon.sh" start master
  echo
}

start_regionserver(){
  echo "Starting HBase RegionServer..."
  "${HBASE_HOME}/bin/hbase-daemon.sh" start regionserver
  echo
}

start_rest(){
  echo "Starting HBase REST..."
  "${HBASE_HOME}/bin/hbase-daemon.sh" start rest
  echo
}

start_thrift(){
  echo "Starting HBase Thrift..."
  "${HBASE_HOME}/bin/hbase-daemon.sh" start thrift
  echo
}

if [ -n "$*" ]; then
  echo "Specified $1"
  if [ "$1" = master ]; then
    start_master
    tail -f /dev/null
  elif [ "$1" = regionserver ]; then
    start_regionserver
    tail -f /dev/null
  elif [ "$1" = rest ]; then
    start_rest
    tail -f /dev/null
  elif [ "$1" = thrift ]; then
    start_thrift
    tail -f /dev/null
  elif [ "$1" = shell]; then
    "HBASE_HOME/bin/hbase" shell
  elif [ "$1" = bash]; then
    bash
  else
    echo "Please specify one of: master, regionserver, rest, thrift, shell or bash"
  fi
else
  sed -i 's/zookeeper:2181/localhost:2181/' "$HBASE_HOME/conf/hbase-site.xml"
  start_zookeeper
  start_master
  start_regionserver
  start_rest
  start_thrift
fi

wait || :
