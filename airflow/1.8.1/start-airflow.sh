#!/bin/bash

docker version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  docker run -d --name my-airflow -p 8080:8080 -m "2048M" --rm -v $PWD/dags:/usr/local/airflow/dags my/airflow:1.8.1
else
  sudo docker run -d --name my-airflow -p 8080:8080 -m "2048M" --rm -v $PWD/dags:/usr/local/airflow/dags my/airflow:1.8.1
fi

