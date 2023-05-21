FROM centos:centos7
LABEL  maintainer "blueskyarea"

ENV JAVA_VERSION 1.8.0
ENV JAVA_HOME /usr/lib/jvm/jre
ENV SCALA_VERSION 2.13
ENV KAFKA_VERSION 2.6.0
ENV KAFKA_HOME /opt/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION"
ENV APACHE_PRJ http://apache.mirrors.spacedump.net

# common
RUN yum clean all; \
    yum check-update; \
    yum update; \
    yum install -y curl which tar sudo rsync wget

# java
RUN yum install -y java-"$JAVA_VERSION"-openjdk; \
    rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

# kafka
RUN wget "$APACHE_PRJ"/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz; \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt; \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz; \
    ln -nfs "$KAFKA_HOME" /opt/kafka

# supervisor
RUN yum install -y python-setuptools; \
    easy_install supervisor; \
    echo_supervisord_conf > /etc/supervisord.conf; \
    mkdir /supervisord.conf.from.local

# script for starting zookeeper & kafka server.
ADD scripts/start-zookeeper.sh /usr/bin/start-zookeeper.sh
ADD scripts/start-kafka.sh /usr/bin/start-kafka.sh
RUN chmod +x /usr/bin/start-zookeeper.sh /usr/bin/start-kafka.sh

# configuration for supervisor(zookeeper & kafka)
ADD config/supervisor/kafka.conf config/supervisor/zookeeper.conf /supervisord.conf.from.local/
RUN cat /supervisord.conf.from.local/kafka.conf >> /etc/supervisord.conf; \
    cat /supervisord.conf.from.local/zookeeper.conf >> /etc/supervisord.conf 

EXPOSE 2181 9092

CMD ["supervisord", "-n"]
