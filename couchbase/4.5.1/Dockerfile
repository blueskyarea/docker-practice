FROM centos:centos6
LABEL maintainer "blueskyarea"

USER root

RUN yum clean all; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync; \
    yum update -y libselinux

# supervisor
RUN yum install -y python-setuptools; \
    easy_install supervisor; \
    echo_supervisord_conf > /etc/supervisord.conf; \
    mkdir /supervisord.conf.from.local

# couchbase install
RUN rpm -ivh http://packages.couchbase.com/releases/4.5.1/couchbase-server-community-4.5.1-centos6.x86_64.rpm

# script for starting couchbase server
ADD scripts/start-couchbase.sh /usr/bin/start-couchbase.sh
RUN chmod +x /usr/bin/start-couchbase.sh

# configuration for supervisor(couchbase)
ADD config/supervisor/couchbase.conf supervisord.conf.from.local/
RUN cat /supervisord.conf.from.local/couchbase.conf >> /etc/supervisord.conf

CMD ["supervisord", "-n"]

