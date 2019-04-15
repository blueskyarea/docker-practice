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
```

### Challenge 1: Get initial temporary mysql password from log
1. To start challenge environment
```
./start-challenge.sh
```

2. Try to get initial temporary mysql password from log
HINT1: Target file is /var/log/mysqld.log

3. To stop challenge environment
```
./stop-challenge.sh
```
Answer : >1ZeSNGprg!)

