package com.blueskyarea;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

import org.apache.commons.lang3.time.StopWatch;

import rx.Observable;
import rx.functions.Func1;

import com.couchbase.client.java.Bucket;
import com.couchbase.client.java.Cluster;
import com.couchbase.client.java.CouchbaseCluster;
import com.couchbase.client.java.document.JsonDocument;
import com.couchbase.client.java.document.json.JsonObject;
import com.couchbase.client.java.env.CouchbaseEnvironment;
import com.couchbase.client.java.env.DefaultCouchbaseEnvironment;

public class HelloCouchbase {
	// connection
	private String serverIp = "172.25.0.1";
	private String bucketName = "default";
	private String password = "";
	private CouchbaseEnvironment env = DefaultCouchbaseEnvironment.builder()
            .connectTimeout(60000) //60000ms = 60s, default is 5s
            .build();
	private Cluster cluster = CouchbaseCluster.create(env, serverIp);
	private Bucket bucket = cluster.openBucket(bucketName, password);
	private StopWatch stopWatch = new StopWatch();
	
    public static void main( String[] args )    {
    	HelloCouchbase client = new HelloCouchbase();
    	//client.execute();
    	//client.bigPut();
    	client.bulkPut();
    }
    
    protected void execute() {
    	// data preparation
    	JsonObject user = JsonObject.empty()
    		    .put("firstname", "Walter")
    		    .put("lastname", "White")
    		    .put("job", "chemistry teacher")
    		    .put("age", 50);
    	JsonDocument doc = JsonDocument.create("walter", user);
    	
    	// upsert
    	System.out.println("===== upsert =====");
    	JsonDocument response = bucket.upsert(doc);
    	System.out.println(response.id());
    	
    	// retrieve
    	System.out.println("===== retrieve =====");
    	JsonDocument walter = bucket.get("walter");
    	System.out.println("Found: " + walter);
    	
    	// retrieve & upsert
    	System.out.println("===== retrieve & upsert =====");
    	JsonDocument loaded = bucket.get("walter");
    	if (loaded == null) {
    	    System.err.println("Document not found!");
    	} else {
    	    loaded.content().put("age", 52);
    	    JsonDocument updated = bucket.replace(loaded);
    	    System.out.println("Updated: " + updated.id());
    	}
    	
    	// disconnection
    	cluster.disconnect();
    }
    
    protected void bigPut() {   	
    	// data preparation
    	stopWatch.start();
    	IntStream.range(0, 100000).forEach(i -> {
    		JsonObject user = JsonObject.empty()
        		    .put("firstname", "Walter")
        		    .put("lastname", "White")
        		    .put("job", "chemistry teacher")
        		    .put("age", i);
        	JsonDocument doc = JsonDocument.create("walter:" + i, user);
        	bucket.upsert(doc);
    	});
    	stopWatch.stop();
    	System.out.println(stopWatch);
    	stopWatch.reset();
    	
    	// disconnection
    	cluster.disconnect();
    }
    
    protected void bulkPut(){
    	
    	stopWatch.start();
    	
    	List<JsonDocument> jsons = new ArrayList<>();
    	IntStream.range(0, 100000).forEach(i -> {
    		JsonObject user = JsonObject.empty()
        		    .put("firstname", "Walter")
        		    .put("lastname", "White")
        		    .put("job", "chemistry teacher")
        		    .put("age", i);
        	JsonDocument doc = JsonDocument.create("walter:" + i, user);
        	jsons.add(doc);
    	});

    	
    	Observable
        .from(jsons)
        .flatMap(new Func1<JsonDocument, Observable<JsonDocument>>() {
            @Override
            public Observable<JsonDocument> call(final JsonDocument docToInsert) {
                return bucket.async().upsert(docToInsert);
            }
        })
        .last()
        .toBlocking()
        .single();
    	
    	stopWatch.stop();
    	System.out.println(stopWatch);
    	stopWatch.reset();
    	
    	// disconnection
    	cluster.disconnect();
    }
}
