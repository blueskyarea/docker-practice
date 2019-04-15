#!/bin/bash

docker version > /dev/null 2>&1
if [ $? -eq 0 ]; then
  docker run -t -d --name my-bash-challenge --rm my/bash-challenge:1.0.0 &&
  docker exec -it my-bash-challenge bash
else
  sudo docker run -t -d --name my-bash-challenge --rm my/bash-challenge:1.0.0 &&
  sudo docker exec -it my-bash-challenge bash
fi

