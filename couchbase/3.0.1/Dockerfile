FROM centos:centos6
LABEL  maintainer "blueskyarea"

USER root

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync
RUN yum update -y libselinux

# couchbase repo
#RUN curl -O http://packages.couchbase.com/releases/couchbase-release/couchbase-release-3.0-1-x86_64.rpm

#RUN curl -O http://packages.couchbase.com/releases/3.0.1/couchbase-server-community-3.0.1-centos6.x86_64.rpm
#RUN rpm -i couchbase-server-community-3.0.1-centos6.x86_64.rpm

# couchbase install
#RUN yum update -y
#RUN yum install -y couchbase-server-community

RUN rpm -ivh http://packages.couchbase.com/releases/3.0.1/couchbase-server-community-3.0.1-centos6.x86_64.rpm
