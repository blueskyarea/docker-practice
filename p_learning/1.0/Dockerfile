FROM centos:centos6
LABEL maintainer "blueskyarea"

USER root

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y curl which tar sudo openssh-server openssh-clients rsync; \
    yum install -y yum-utils; \
    yum-config-manager --enable base/6/x86_64
RUN yum update -y libselinux

# supervisor
RUN yum install -y python-setuptools; \
    easy_install supervisor; \
    echo_supervisord_conf > /etc/supervisord.conf; \
    mkdir /supervisord.conf.from.local

# mysql install
RUN yum install -y mysql-server-5.1*

# php install
RUN yum install -y php; \
    yum install -y php-pdo; \
    yum install -y php-pdo_mysql

# script for starting mysql server
ADD scripts/start-mysql.sh /usr/bin/start-mysql.sh
ADD sqls /sqls
RUN chmod +x /usr/bin/start-mysql.sh

# script for starting apache web server
ADD scripts/start-apache.sh /usr/bin/start-apache.sh
RUN chmod +x /usr/bin/start-apache.sh

# configuration for supervisor
ADD config/supervisor/mysql.conf config/supervisor/apache.conf /supervisord.conf.from.local/
RUN cat /supervisord.conf.from.local/mysql.conf >> /etc/supervisord.conf; \
    cat /supervisord.conf.from.local/apache.conf >> /etc/supervisord.conf 

CMD ["supervisord","-n"]

