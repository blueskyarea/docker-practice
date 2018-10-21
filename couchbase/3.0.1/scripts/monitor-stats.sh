#!/bin/bash

HOST=$1
BUCKET=$2

if [ -z $HOST ]; then
  echo "please specify hostname to get stats."
  exit 1
fi

if [ -z $BUCKET ]; then
  echo "please specify bucket to get stats."
fi

while [ true ]
do
  NOW=`date +"%Y-%m-%d %H:%M:%S"`
  STATS=`"/opt/couchbase/bin/cbstats" -b $BUCKET $HOST:11210 all | awk '{printf "%s,", $2}' | awk '{print}'`
  echo $NOW,$STATS
  sleep 5
done

