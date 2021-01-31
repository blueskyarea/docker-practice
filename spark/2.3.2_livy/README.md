# docker-spark

0. Create docker network
```
docker network create spark-nw --subnet=172.30.0.0/16 --gateway=172.30.0.254
```

1. Build and start
```
docker-compose up --build -d
```

#2. Start spark-shell
#```
#docker-compose exec spark-master /spark/bin/spark-shell --master spark://localhost:7077
#```

2. Start Livy session
```
curl -XPOST -H 'Content-Type: application/json' localhost:8998/sessions -d \
'{
  "driverMemory": "1G",
  "driverCores": 1,
  "executorMemory": "1G",
  "executorCores": 1,
  "numExecutors": 1
}'
```

3. Example1 to use the Livy session
```
curl localhost:8998/sessions/0/statements -X POST -H 'Content-Type: application/json' -d \
'{
  "code":"val x = 5 + 5", 
  "kind": "scala"
}'
```

4. Example2 to use the Livy session
```
curl localhost:8998/sessions/0/statements -X POST -H 'Content-Type: application/json' -d \
'{
  "code":"val y = x * 10", 
  "kind": "scala"
}'
```

5. Access Livy Web UI
```
http://localhost:8998
```

6. Stop Livy session
```
curl -XDELETE localhost:8998/sessions/[session-id]
```

7. Try to exexute batch
```
curl localhost:8998/batches -XPOST -H 'Content-Type: application/json' -d \
'{
  "file": "/spark/examples/jars/spark-examples_2.11-2.3.2.jar",
  "className": "org.apache.spark.examples.SparkPi",
  "args": [2000],
  "numExecutors": 2,
  "executorCores": 1
}'
```
