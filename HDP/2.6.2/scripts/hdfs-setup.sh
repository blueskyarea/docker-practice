#!/bin/bash

set -e

hdfs dfs -mkdir -p /data/mllib/word2vec
hdfs dfs -put /spark/data/mllib/word2vec/* /data/mllib/word2vec/

exit 0

