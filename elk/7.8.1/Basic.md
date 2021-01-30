#### Create
From kibana dev tools, 
1.
```
PUT my_index/_doc/1
{
  "name":"PUT man",
  "message":"Hello PUT!!"
}
```

Response
```
{
  "_index" : "my_index",
  "_type" : "_doc",
  "_id" : "1",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 2,
    "failed" : 0
  },
  "_seq_no" : 0,
  "_primary_term" : 1
}
```

2.
```
POST my_index/_doc/
{
  "name":"POST man",
  "message":"Hello POST!!"
}
```

Response (id creates automatically)
```
{
  "_index" : "my_index",
  "_type" : "_doc",
  "_id" : "a2DTQ3cBIQnyKzgOQA9W",
  "_version" : 1,
  "result" : "created",
  "_shards" : {
    "total" : 2,
    "successful" : 2,
    "failed" : 0
  },
  "_seq_no" : 1,
  "_primary_term" : 1
}
```

#### READ
1. _doc
```
GET my_index/_doc/1
```

2. _source
```
GET my_index/_source/1
```

3. _search
```
GET my_index/_search
{
  "query":{
    "match":{
      "message":"Hello"
    }
  }
}
```
