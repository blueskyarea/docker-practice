### Step 1: Build image of spark2

1. Go to directory that has Dockerfile.

2. Execute below command to build image.
```
docker build -t my/spark:2.4.1 -f Dockerfile .
```

### Step 2: Create container of spark2 & run
```
docker-compose up -d
```

### Step 3: Try to use spark-shell
```
docker-compose exec master /spark/bin/spark-shell --master spark://localhost:7077
```

### Step 4: Stop docker container & remove
```
docker stop my-spark-master my-spark-worker && docker rm $(docker ps -a -q)
```

### Try : Beginning of MLlib
1. start spark-shell
```
docker-compose exec master /spark/bin/spark-shell --master spark://localhost:7077
```

2. read sample data
```
import org.apache.spark.mllib.clustering.KMeans
import org.apache.spark.mllib.linalg.Vectors
val sparkHome = "/spark"
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

