### Step 1: Build image of spark2

1. Go to directory that has Dockerfile.

2. Execute below command to build image.
```
docker build -t my/spark:2.4.1 -f Dockerfile .
```

### Step 2: Create container of spark2 & run
```
docker-compose up -d
```

### Step 3: Try to use spark-shell
```
docker-compose exec master /spark/bin/spark-shell --master spark://localhost:7077
```

### Step 4: Stop docker container & remove
```
docker stop my-spark-master my-spark-worker && docker rm $(docker ps -a -q)
```

