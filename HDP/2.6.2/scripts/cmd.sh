#!/bin/bash
set -e

/usr/hdp/2.6.2.0-205/hadoop-yarn/sbin/yarn-daemon.sh start resourcemanager &&
echo "Y" | /usr/hdp/2.6.2.0-205/hadoop/bin/hdfs --config /etc/hadoop/conf namenode -format &&
/usr/hdp/2.6.2.0-205/hadoop/sbin/hadoop-daemon.sh start namenode &&
while true; do sleep 1000; done

echo "started."
