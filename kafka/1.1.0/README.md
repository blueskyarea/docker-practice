### Step 1: Build image of kafka
1. Go to directory that has Dockerfile.

2. Execute below command to build image.
```
docker build -t my/kafka:1.1.0 .
```
3. Confirm the created image.
```
docker images
```
```
REPOSITORY        TAG                 IMAGE ID            CREATED             SIZE
my/kafka          1.1.0               241ec6eba294        9 minutes ago       515MB
```

### Step 2: Create container of kafka & run
1. Execute below command to create container & start.
```
docker run --name my-kafka my/kafka:1.1.0
```
If success to start, like below message will be shown.
```
2018-XX-XX 03:47:09,116 INFO success: zookeeper entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2018-XX-XX 03:47:09,118 INFO success: kafka entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```
This console is running with daemon process(container of zookeeper & kafka).  
If ctrl+C, this container will be stopped.

### Step 3: Prepare to use kafka
1. Create topic (Please open other console to execute below)  
In this example, the topic name is "topic1".
```
docker exec -it my-kafka /opt/kafka/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic topic1
```
If success, below message will be shown.
```
Created topic "topic1".
```

2. Start Producer  
Producer publishs a stream of records to one or more Kafka topics.
```
docker exec -it my-kafka /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic topic1
```
This console will be standby for input like below.
```
>
```

3. Start Consumer (Please open other console to execute below)  
Consumer subscribes to one or more topics and process the stream of records.
```
docker exec -it my-kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic topic1
```
If you want to get message from begining, please add option "--from-beginning".

### Step 4: Try to use kafka
Input something message from console of Producer.
```
>this is first message.
```

You will see the same message in console of Consumer.
```
this is first message.
```

### Stop container
You can stop this container with ctrl+C in running kafka-server console.

If the container was started by start command.
```
docker stop my-kafka
```

### Start container
You can start this container with below command, if the container is already created.
```
docker start my-kafka
```
