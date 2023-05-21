FROM debian:9
LABEL  maintainer "blueskyarea"

SHELL ["/bin/bash", "-c"]

# install dev tools
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  vim \
  systemd \
  net-tools \
  curl \
  netcat \
  gnupg \
  telnet \
  rsync \
  openssh-server \
  openssh-client
      
# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key <<< y
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key <<< y
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa <<< y
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Java
RUN apt-get install -y openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $PATH:$JAVA_HOME/bin

# Hadoop
ENV HADOOP_VERSION 3.1.3
ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN mkdir /opt/hadoop
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz --insecure \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/hadoop/ \
    && rm -f /tmp/hadoop.tar.gz*

RUN ln -nfs /opt/hadoop/hadoop-$HADOOP_VERSION /opt/hadoop/current
RUN ln -s /opt/hadoop/current/etc/hadoop /etc/hadoop
RUN mkdir /opt/hadoop/current/logs
RUN mkdir /hadoop-data

ENV HADOOP_HOME /opt/hadoop/current
ENV PATH $PATH:$HADOOP_HOME/bin
ENV HDFS_NAMENODE_USER root
ENV HDFS_DATANODE_USER root
ENV HDFS_SECONDARYNAMENODE_USER root
ENV YARN_RESOURCEMANAGER_USER root
ENV YARN_NODEMANAGER_USER root

COPY base/config/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
COPY base/config/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
COPY base/config/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
COPY base/config/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
COPY base/config/hadoop-env.sh $HADOOP_HOME/etc/hadoop/hadoop-env.sh
COPY base/config/workers $HADOOP_HOME/etc/hadoop/workers
COPY base/script/start.sh $HADOOP_HOME/start.sh
RUN chmod +x $HADOOP_HOME/start.sh
RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8020 8040 8088 9000 9870 19888 50070

CMD ["/opt/hadoop/current/start.sh"]

