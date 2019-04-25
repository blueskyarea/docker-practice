### Step 1: Build image of airflow
1. Go to directory that has Dockerfile.

2. Execute below command to build image.
```
docker build -t my/bash-challenge:1.0.0 -f Dockerfile .
```

3. Confirm the created image.
```
docker images
```
```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
my/bash-challenge   1.0.0               2dda34ccce16        19 minutes ago      232MB
```
### Challenge start and stop
1. To start challenge environment
```
./start-challenge.sh
```

2. To stop challenge environment
```
./stop-challenge.sh
```

### Challenge 1: Get initial temporary mysql password from log
Target file is /var/log/mysqld.log

Required value : >1ZeSNGprg!)

### Challenge 2: Get value of org.apache.slider.hbase.rest
Target file are /var/log/slider.log & /var/log/slider2.log

Required value : http://server4:50000

