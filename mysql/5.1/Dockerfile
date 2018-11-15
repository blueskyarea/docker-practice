FROM centos:centos6
LABEL maintainer "blueskyarea"

USER root

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync
RUN yum update -y libselinux

# mysql install
RUN yum install -y mysql-server-5.1*

CMD ["top","-b"]

