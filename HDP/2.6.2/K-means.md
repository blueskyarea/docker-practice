### Try K-means

1. start spark-shell
```
docker exec -it my-hdp-spark-client /usr/hdp/2.6.2.0-205/spark2/bin/spark-shell -i /spark/src/mllib/kmeans.scala
```

2. read sample data
```
val testData = sc.textFile("file://" + sparkHome + "/data/mllib/kmeans_data.txt")
val parsedData = testData.map{ d => Vectors.dense(d.split(' ').map(_.toDouble)) }.cache()
```

3. create model
```
val numClusters = 2
val numIterations = 20
val clusters = KMeans.train(parsedData, numClusters, numIterations)
```

4. get number of cluster
```
clusters.k
```

5. get coordinates of clusters
```
clusters.clusterCenters
```

6. predict cluster for new vector
```
val newVec1 = Vectors.dense(0.3, 0.3, 0.3)
clusters.predict(newVec1)

val newVec2 = Vectors.dense(8.0, 8.0, 8.0)
clusters.predict(newVec2)
```

7. check cluster for original vector
```
parsedData.collect.foreach(vec => println(vec + " => " + clusters.predict(vec)))
```

8. WSSSE(Within Set Sum of Squared Errors) for considering number of cluster
```
val WSSSE = clusters.computeCost(parsedData)
```
If increase number of cluster, the value will be decreased.
If the difference become to less, the number of cluster is most likely optimum.

9. save model
```
clusters.save(sc, "/tmp/kmeans_model")
```

10. load model
```
import org.apache.spark.mllib.clustering.KMeansModel
val loadedModel = KMeansModel.load(sc, "/tmp/kmeans_model")
```

