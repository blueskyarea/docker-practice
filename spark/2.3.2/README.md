# docker-spark

0. Create docker network
```
docker network create spark-nw --subnet=172.30.0.0/16 --gateway=172.30.0.254
```

1. Build and start
```
docker-compose up --build -d
```

2. Start spark-shell
```
docker-compose exec spark-master /spark/bin/spark-shell --master spark://localhost:7077
```
