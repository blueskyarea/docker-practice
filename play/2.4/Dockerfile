FROM centos:centos7
LABEL maintainer "blueskyarea"

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync
RUN yum update -y libselinux

CMD ["top","-b"]

