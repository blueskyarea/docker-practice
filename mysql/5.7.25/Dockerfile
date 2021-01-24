FROM centos:centos7
LABEL maintainer "blueskyarea"

USER root

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync
RUN yum update -y libselinux

# resolve dependency
RUN yum -y install perl.x86_64; \
    yum install -y libaio.x86_64; \
    yum -y install net-tools.x86_64; \
    yum -y install numactl*.x86_64

# mysql repo
RUN rpm -ihv http://dev.mysql.com/get/mysql-community-common-5.7.25-1.el7.x86_64.rpm; \
    rpm -ihv http://dev.mysql.com/get/mysql-community-libs-5.7.25-1.el7.x86_64.rpm; \
    rpm -ihv http://dev.mysql.com/get/mysql-community-client-5.7.25-1.el7.x86_64.rpm; \
    rpm -ihv http://dev.mysql.com/get/mysql-community-server-5.7.25-1.el7.x86_64.rpm
RUN yum --disablerepo=\* --enablerepo='mysql-community*' list available

# mysql install
RUN yum --enablerepo='mysql-community*' install -y mysql-community-server
