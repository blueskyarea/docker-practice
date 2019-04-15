#!/bin/bash

docker version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  docker stop my-bash-challenge
else
  sudo docker stop my-bash-challenge
fi

