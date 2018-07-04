#!/bin/bash

# start HMaster
/usr/hdp/current/hbase-master/bin/hbase-daemon.sh start master; sleep 10

# start Region server
/usr/hdp/current/hbase-regionserver/bin/hbase-daemon.sh start regionserver
