#!/bin/bash

docker version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  docker stop my-airflow
else
  sudo docker stop my-airflow
fi

