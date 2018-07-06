FROM centos:centos6
LABEL  maintainer "blueskyarea"

ENV JAVA_VERSION 1.8.0
ENV JAVA_HOME /usr/java/default
ENV SCALA_VERSION 2.11
ENV KAFKA_VERSION 1.1.0
ENV APACHE_PRJ http://apache.mirrors.spacedump.net

# common
RUN yum install -y curl which tar sudo rsync wget

# java
ENV PATH $PATH:$JAVA_HOME/bin
RUN yum clean all; \
    yum check-update; \
    yum update; \
    yum install -y java-"$JAVA_VERSION"-openjdk; \
    rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

# kafka
RUN wget -q "$APACHE_PRJ"/kafka/"$KAFKA_VERSION"/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -O /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz; \
    tar xfz /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz -C /opt; \
    rm /tmp/kafka_"$SCALA_VERSION"-"$KAFKA_VERSION".tgz

# supervisor
#RUN yum --enablerepo=epel install -y supervisor
RUN yum install -y python-setuptools; \
    easy_install supervisor

EXPOSE 2181 9092

CMD ["supervisord", "-n"]

