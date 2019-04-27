### Step 1: Build image of airflow
1. Go to directory that has Dockerfile.

2. Execute below command to build cluster & client image.
```
docker build -t my/hdp-cluster:2.6.2 -f Dockerfile.cluster .
```
```
docker build -t my/hdp-client:2.6.2 -f Dockerfile.client .
```

3. Confirm the created image.
```
docker images
```
```
REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
my/hdp-cluster      2.6.2               2f7e7b366df2        About a minute ago   988MB
```

### Step 2: Create container of spark-master & run
1. Execute below command to create container & start.
```
docker run -t -d --name my-hdp-master --hostname="spark-master" --rm -p 8080:8080 my/hdp-cluster:2.6.2
```
OR
```
docker-compose up --build -d
```

### Step 3: Stop the container
```
docker stop my-spark-master
```
```
docker stop my-spark-cilent
```

