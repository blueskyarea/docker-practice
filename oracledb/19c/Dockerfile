FROM centos:centos7
LABEL maintainer "blueskyarea"

USER root

# install dev tools
RUN yum update -y libselinux; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync; \
    yum clean all

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install Java
RUN yum install -y java-1.8.0-openjdk
ENV JAVA_HOME /usr/lib/jvm/jre
ENV PATH $PATH:$JAVA_HOME/bin
RUN rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java

# Install Oracle Preinstallation RPM
ENV ORACLE_DOCKER_INSTALL true
RUN yum -y install https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm

# Copy Oracle DB installer from host
ADD installer/oracle-database-ee-19c-1.0-1.x86_64.rpm /tmp/oracle-database-ee-19c-1.0-1.x86_64.rpm

# Disable memlock
# To avoid su: cannot open session: Permission denied during Oracle DB installation
RUN sed -i -e 's/^\(oracle   hard   memlock\)/#\1/' /etc/security/limits.d/oracle-database-preinstall-19c.conf

# Install Oracle DB
RUN yum -y localinstall /tmp/oracle-database-ee-19c-1.0-1.x86_64.rpm

# Replace a localhost ip address
RUN cp /etc/hosts ~/hosts.new; \
    sed -i 's/127.0.0.1/172.50.0.2/g' ~/hosts.new; \
    cp -f ~/hosts.new /etc/hosts

ENV ORACLE_BASE=/opt/oracle
ENV ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
ENV ORACLE_SID=ORCLCDB

RUN /etc/init.d/oracledb_ORCLCDB-19c configure

RUN echo "export ORACLE_SID=ORCLCDB" >> /home/oracle/.bash_profile
RUN echo "export ORACLE_BASE=/opt/oracle" >> /home/oracle/.bash_profile
RUN echo "export ORACLE_HOME=$ORACLE_BASE/product/19c/dbhome_1" >> /home/oracle/.bash_profile
RUN echo "export PATH=$PATH:$ORACLE_HOME/bin" >> /home/oracle/.bash_profile

ENTRYPOINT ["tail", "-f", "/dev/null"]

