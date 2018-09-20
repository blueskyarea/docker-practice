### Step 1: Build image of couchbase
1. Go to directory that has Dockerfile.

2. Execute below command to build image.
```
docker build -t my/couchbase:3.0.1 .
```
3. Confirm the created image.
```
docker images
```
```
REPOSITORY        TAG                 IMAGE ID            CREATED             SIZE
my/couchbase      3.0.1               241ec6eba294        9 minutes ago       515MB
```

### Step 2: Create container of couchbase & run
1. Execute below command to create container & start.
```
docker run --name my-couchbase my/couchbase:3.0.1
```
If success to start, like below message will be shown.
```
2018-XX-XX 15:04:04,842 INFO success: couchbase entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```
This console is running with daemon process(container of couchbase server).  
If ctrl+C, this container will be stopped.


### Stop container
You can stop this container with ctrl+C in running couchbase-server console.

If the container was started by start command.
```
docker stop my-couchbase
```

### Start container
You can start this container with below command, if the container is already created.
```
docker start my-couchbase
```
