curl -XGET http://localhost:18080/nifi-registry-api/access


## Get all buckets in a Registry 
curl -XGET http://localhost:18080/nifi-registry-api/buckets

## Get all flows in a Bucket 
curl -XGET http://localhost:18080/nifi-registry-api/buckets/e4af46d7-4cf0-41f6-aa8e-06029277d00a/flows

## Get a Flow from a Bucket 
curl -XGET http://localhost:18080/nifi-registry-api/buckets/e4af46d7-4cf0-41f6-aa8e-06029277d00a/flows/5213de8c-57df-48a5-b591-6d5d13eae32b



## Get a Flow at a version from a Bucket 
curl -XGET http://localhost:18080/nifi-registry-api/buckets/e4af46d7-4cf0-41f6-aa8e-06029277d00a/flows/5213de8c-57df-48a5-b591-6d5d13eae32b/versions/1