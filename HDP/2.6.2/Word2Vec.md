### Try Word2Vec

1. start spark-shell
```
docker exec -it my-hdp-spark-client /usr/hdp/2.6.2.0-205/spark2/bin/spark-shell --master yarn --deploy-mode client --packages org.apache.lucene:lucene-kuromoji:3.6.2 --conf spark.serializer=org.apache.spark.serializer.KryoSerializer -i /spark/src/mllib/word2vec.scala
```

2. read text file
```
val input = sc.textFile("/data/mllib/word2vec").map(line => tokenize(line))
```

3. set minimum appearance number & vector dimension number
```
val word2vec = new Word2Vec()
word2vec.setMinCount(3)
word2vec.setVectorSize(30)
```

4. create model
```
val model = word2vec.fit(input)
```

5. find synonims
```
model.findSynonyms("平成",5)
model.findSynonyms("昭和",5)
model.findSynonyms("天皇",5)
model.findSynonyms("日本",5)
model.findSynonyms("憲法",5)
model.findSynonyms("元号",5)
```
