#!/bin/bash

set -e

su - zookeeper -c "export ZOOCFGDIR=/usr/hdp/2.6.2.0-205/zookeeper/conf ; export ZOOCFG=zoo.cfg; source /usr/hdp/2.6.2.0-205/zookeeper/conf/zookeeper-env.sh ; export ZOO_LOG_DIR=/var/log/zookeeper ;  /usr/hdp/current/zookeeper-server/bin/zkServer.sh start"

exit 0

