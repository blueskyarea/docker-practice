#### Start cluster
```
$ docker-compose up --build -d
```

#### Stop cluster
```
$ docker stop $(docker ps -q)
```

#### Check cluster info
```
$ curl -XGET http://localhost:9200/_cluster/health?pretty
```

If below message, still starting elasticsearch process. Please wait.
```
curl: (56) Recv failure: Connection reset by peer
```

After started elasticsearch process, should response like below.
If "status" is green, this cluster is started properly.
The "number_of_nodes" is "3", because started 3 containers of elasticsearch node.

```
{
  "cluster_name" : "es-docker-cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 3,
  "number_of_data_nodes" : 3,
  "active_primary_shards" : 0,
  "active_shards" : 0,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 25,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 16813,
  "active_shards_percent_as_number" : 100.0
}
```

#### Check who is master
```
$ curl -XGET http://localhost:9200/_cat/master?v=true
id                     host        ip          node
GJCtO6DxTOuAnnB4SushXQ 172.30.10.3 172.30.10.3 es03
```

Other elasticsearch response same, it means agree on the master.
```
$ curl -XGET http://localhost:9201/_cat/master?v=true
id                     host        ip          node
GJCtO6DxTOuAnnB4SushXQ 172.30.10.3 172.30.10.3 es03
$ curl -XGET http://localhost:9202/_cat/master?v=true
id                     host        ip          node
GJCtO6DxTOuAnnB4SushXQ 172.30.10.3 172.30.10.3 es03
```
