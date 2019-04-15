FROM centos:centos7 
LABEL maintainer "blueskyarea"

RUN yum update -y libselinux; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync; \
    yum clean all

COPY files/mysqld.log /var/log/mysqld.log

