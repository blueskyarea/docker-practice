#!/usr/bin/env bash

set -euo pipefail

mkdir -p /tmp/zookeeper
cd /tmp
zkServer.sh start
sleep 30
tail -f /dev/null &
wait || :

