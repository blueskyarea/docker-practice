#### Before stop node
##### Disable replica shards rebalance
```
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "primaries"
  }
}
```

##### Execute synced flush
```
POST _flush/synced
```

##### Check current Master node
```
GET _cat/nodes?v
```

##### Stop node 1 by 1
For example,
```
$ docker stop es03
```

If this is real server,
```
$ systemctl stop elasticsearch
```

##### Start node 1 by 1
For example,
```
$ docker start es03
```

If this is real server,
```
$ systemctl start elasticsearch
```

##### Enable replica shards rebalance
```
PUT _cluster/settings
{
  "persistent": {
    "cluster.routing.allocation.enable": "null"
  }
}
```
