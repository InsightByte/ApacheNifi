
# How to manage/interact with NiFi using the Rest Api endpoints.

NiFi Rest Api documentation can be found at https://nifi.apache.org/docs/nifi-docs/rest-api/index.html


### A processor has 3 States **RUNNING, STOPPED & DISABLED**

### And to be able to change it's state you will need to do the following:
1. You need to find the processor ID (use PG Name and Processor Name).
2. Find the current Version of the Processor.
3. Find current state. (this )
4. Build Payload.

## Export some parameters
```
export hostname='localhost'
export port='8081'
export pg_name='test_pg'
export processors_name='Start'
```

## Get PG Id using PG name
```
export resources=`curl -XGET http://$hostname:$port/nifi-api/resources`
export pg_name='test_pg'
export pg_id_string=`echo $resources| jq -c '.resources[] | select(.name| contains ("'$pg_name'")) | .identifier' | grep -v 'data\|policies\|operation' | grep 'process-groups' | tr -d '"'`
export pg_id=${pg_id_string/\/process-groups\//}
```

## Get Processor Id using PG Id and Processor Name
```
export processors=`curl http://$hostname:$port/nifi-api/flow/process-groups/$pg_id`
export processor_id=`echo $processors | jq -c '.processGroupFlow.flow.processors[]| select(.component.name | contains("'$processors_name'")) | .component.id' | tr -d '"'`
export processor_version=`echo $processors | jq -c '.processGroupFlow.flow.processors[]| select(.component.name | contains("'$processors_name'")) | .revision.version' | tr -d '"'`
export processor_status=`echo $processors | jq -c '.processGroupFlow.flow.processors[]| select(.component.name | contains("'$processors_name'")) | .status.runStatus' | tr -d '"'`
export clientId=$(uuidgen | tr "[:upper:]" "[:lower:]")
```

# How to START as Processor
```
curl -H 'Content-Type: application/json' -XPUT -d '''
{
  "status": {
    "runStatus": "RUNNING"
  },
  "component": {
    "state": "RUNNING",
    "id": "'$processor_id'"
  },
  "id": "'$processor_id'",
  "revision": {
    "version": '$processor_version',
    "clientId": "'$clientId'"
  }
} ''' http://$hostname:$port/nifi-api/processors/$processor_id
```

# How to STOP as Processor
```
curl -H 'Content-Type: application/json' -XPUT -d '''
{
  "status": {
    "runStatus": "STOPPED"
  },
  "component": {
    "state": "STOPPED",
    "id": "'$processor_id'"
  },
  "id": "'$processor_id'",
  "revision": {
    "version": '$processor_version',
    "clientId": "'$clientId'"
  }
} ''' http://$hostname:$port/nifi-api/processors/$processor_id
```


# How to DISABLE as Processor
```
curl -H 'Content-Type: application/json' -XPUT -d '''
{
  "status": {
    "runStatus": "DISABLED"
  },
  "component": {
    "state": "DISABLED",
    "id": "'$processor_id'"
  },
  "id": "'$processor_id'",
  "revision": {
    "version": '$processor_version',
    "clientId": "'$clientId'"
  }
} ''' http://$hostname:$port/nifi-api/processors/$processor_id
```


# How to Start and Stop Process Group 

## Get PG Id using PG name
```
export resources=`curl -XGET http://$hostname:$port/nifi-api/resources`
export pg_id_string=`echo $resources| jq -c '.resources[] | select(.name| contains ("'$pg_name'")) | .identifier' | grep -v 'data\|policies\|operation' | grep 'process-groups'`
export pg_id="${pg_id_string/\/process-groups\//}"
```

### To Start a Proces Group  
```
curl -H 'Content-Type: application/json' -XPUT -d '{"id":"'$pg_id'","state":"RUNNING"}' http://$hostname:$port/nifi-api/flow/process-groups/$pg_id
```
### To Stop a Proces Group  
```
curl -H 'Content-Type: application/json' -XPUT -d '{"id":"'$pg_id'","state":"STOPPED"}' http://$hostname:$port/nifi-api/flow/process-groups/$pg_id
```

curl -i -X PUT -H 'Content-Type: application/json' -d '{"revision":{"version":??,"clientId":"test"},"processor":{"id":"20eb7bbd-2f68-4538-aa13-0f4fa33e63c4","state":"RUNNING"}}' 



http://localhost:8080/nifi-api/process-groups/d090bc40-0180-1000-f1dc-2b64efc5a2ab/process-groups



