# Build and Start docker container

At directory that has docker-compose.yml file, execute
```
$ docker-compose up --build -d
```

# Comfirm build image

```
$ docker images
REPOSITORY                                      TAG                 IMAGE ID            CREATED             SIZE
hadoop-base                                     latest              b95ff379012f        5 minutes ago       999MB
```

# Start

```
$ docker run --name hadoop-base-container hadoop-base:latest
```
