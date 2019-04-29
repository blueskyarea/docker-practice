#!/bin/bash

STOP_TARGET="my-hdp-spark-master my-hdp-spark-worker my-hdp-spark-client"

docker version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  docker stop ${STOP_TARGET}
else
  sudo docker stop ${STOP_TARGET}
fi

