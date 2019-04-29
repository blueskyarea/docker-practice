### Try Word2Vec

1. start spark-shell
```
docker exec -it my-hdp-spark-client /usr/hdp/2.6.2.0-205/spark2/bin/spark-shell --master yarn --deploy-mode client --packages org.apache.lucene:lucene-kuromoji:3.6.2 --conf spark.serializer=org.apache.spark.serializer.KryoSerializer -i /spark/src/mllib/word2vec.scala
```
