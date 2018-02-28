FROM centos:centos6
LABEL  maintainer "blueskyarea"

USER root

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync
RUN yum update -y libselinux

# mysql repo
RUN rpm -ihv http://dev.mysql.com/get/mysql57-community-release-el6-7.noarch.rpm
RUN yum --disablerepo=\* --enablerepo='mysql57-community*' list available

# mysql install
RUN yum --enablerepo='mysql57-community*' install -y mysql-community-server


