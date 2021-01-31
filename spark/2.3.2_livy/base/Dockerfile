FROM alpine:3.10
LABEL maintainer "blueskyarea"

ENV SPARK_VERSION=2.3.2
ENV HADOOP_VERSION=2.7

# Spark
RUN apk add --no-cache curl bash openjdk8-jre libc6-compat \
  && ln -s /lib64/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.2 \
  && wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
  && tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
  && mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark \
  && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

# Livy
#RUN wget http://mirror.23media.de/apache/incubator/livy/0.7.0-incubating/livy-0.7.0-incubating-bin.zip -O /tmp/livy.zip
RUN wget http://mirror.23media.de/apache/incubator/livy/0.7.0-incubating/apache-livy-0.7.0-incubating-bin.zip -O /tmp/livy.zip
RUN unzip /tmp/livy.zip -d /opt/
# Logging dir
RUN mkdir /opt/apache-livy-0.7.0-incubating-bin/logs

EXPOSE 8080 8998

# start from init folder
ADD init /opt/docker-init
COPY conf/livy.conf /opt/apache-livy-0.7.0-incubating-bin/conf/
WORKDIR /opt/docker-init
#ENTRYPOINT ["./entrypoint"]
