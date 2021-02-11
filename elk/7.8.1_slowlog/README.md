### Start cluster
```
$ docker-compose up --build -d
```

### Stop cluster
```
$ docker stop $(docker ps -q)
```

### Try slowlog
#### 1. setup filebeat
```
$ docker exec -it filebeat-slowlog1 filebeat setup -e 
```
This command may take time because waiting kibana starting.

#### 2. Congigure slowlog
Open kibana console.
http://localhost:5601/app/kibana#/dev_tools/console

And execute below query.
Create index.

```
PUT my_index_slowlog/_doc/1
{
  "name":"slowlog man",
  "message":"Hello slowlog!!"
}
```

Configure slowlog for search

```
PUT /my_index_slowlog/_settings
{
  "index.search.slowlog.threshold.query.warn": "10s",
  "index.search.slowlog.threshold.query.info": "5s",
  "index.search.slowlog.threshold.query.debug": "0ms",
  "index.search.slowlog.threshold.query.trace": "500ms",
  "index.search.slowlog.level": "debug"
}
```

Execute any query to output log

```
GET /my_index_slowlog/_search
{
  "query": {
    "match_all": {}
  }
}
```

#### 3. Check slowlog

```
docker exec -it es-slowlog01 cat ./logs/es-docker-cluster_index_search_slowlog.log
```

Should can see slow log like below.

```
[2021-02-11T05:48:35,841][DEBUG][index.search.slowlog.query] [es01] [my_index_slowlog][0] took[368.7micros], took_millis[0], total_hits[1 hits], types[], stats[], search_type[QUERY_THEN_FETCH], total_shards[1], source[{"query":{"match_all":{"boost":1.0}}}], id[], 
```

#### 4. Check index of slowlog
To get index name which is created by filebeat

```
GET /_cat/indices?v
```
The name should be like "filebeat-7.8.1-yyyy.MM.dd-000001"

To search the slowlog in index which is feed by filebeat

```
GET /filebeat-7.8.1-2021.02.11-000001/_search
{
  "sort": [
    {
      "@timestamp": {
        "order": "desc"
      }
    }
  ]
}
```

Should find slowlog like below.
```
{
  "took" : 2,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 2,
      "relation" : "eq"
    },
    "max_score" : null,
    "hits" : [
      {
        "_index" : "filebeat-7.8.1-2021.02.11-000001",
        "_type" : "_doc",
        "_id" : "EfCxj3cBQi14qa4KBI1G",
        "_score" : null,
        "_source" : {
          "@timestamp" : "2021-02-11T06:04:37.851Z",
          "agent" : {
            "type" : "filebeat",
            "version" : "7.8.1",
            "hostname" : "doc-filebeat101",
            "ephemeral_id" : "513a0774-8b14-44e7-a00e-22543c2df1e7",
            "id" : "aa86aae0-a09b-4ab4-acdc-bd5b99ecdfbf",
            "name" : "doc-filebeat101"
          },
          "log" : {
            "offset" : 265,
            "file" : {
              "path" : "/usr/share/elasticsearch/logs/es-docker-cluster_index_search_slowlog.log"
            }
          },
          "message" : """[2021-02-11T06:04:33,865][DEBUG][index.search.slowlog.query] [es01] [my_index_slowlog][0] took[260.6micros], took_millis[0], total_hits[1 hits], types[], stats[], search_type[QUERY_THEN_FETCH], total_shards[1], source[{"query":{"match_all":{"boost":1.0}}}], id[], """,
          "input" : {
            "type" : "log"
          },
          "ecs" : {
            "version" : "1.5.0"
          },
          "host" : {
            "name" : "doc-filebeat101"
          }
        },
        "sort" : [
          1613023477851
        ]
      },
...
```
