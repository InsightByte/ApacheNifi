
# How to Create NiFi Flow Programmatically using NiFi Rest Api

![Flow](https://github.com/InsightByte/ApacheNifi/blob/main/Chapter-13/assets/flow.png)


## See full Video tutorial on How to Create a NiFi Flow Programmatically using NiFi Rest Api 
https://youtu.be/goudIj8R6nM


### Export some parameters to fit your setup
```
export nifi_host="localhost"
export nifi_port="8081"
export clientId=$(uuidgen | tr "[:upper:]" "[:lower:]")
export process_group_name="My Test PG"
```


### Get PG Id using PG name - We are going to Capture the Root Process Group ID
```
export resources=`curl -XGET http://$nifi_host:$nifi_port/nifi-api/resources`
export pg_name='NiFi Flow'
export pg_id_string=`echo $resources| jq -c '.resources[] | select(.name| contains ("'$pg_name'")) | .identifier' | grep -v 'data\|policies\|operation' | grep 'process-groups' | tr -d '"'`
```

### Create Empty PG 
```
export pg_id=`curl -XPOST -H 'Content-Type: application/json' -d '{"revision":{"clientId":"'${clientId}'","version":0},"component":{"name":"'${process_group_name}'","position":{"x":300,"y":-300}}}' http://${nifi_host}:${nifi_port}/nifi-api${pg_id_string}/process-groups | jq -c '.id'| tr -d '"'`
```

### Create Processor inside the Create Process Group and Capture the id 
```
export GenerateFlowFile_id=`curl -XPOST -H 'Content-Type: application/json' -d '{
  "revision": {
    "clientId": "'${clientId}'",
    "version": 0
  },
  
  "component": {
    "type": "org.apache.nifi.processors.standard.GenerateFlowFile",
    "name": "GenerateFlowFile",
    "position": {
      "x": 300,
      "y": -300
    },
    "config": {
     "schedulingPeriod": "300 sec"
    }
  }
}'  http://"${nifi_host}":"${nifi_port}"/nifi-api/process-groups/${pg_id}/processors | jq -c '.id'| tr -d '"'`

export LogAttribute_id=`curl -XPOST -H 'Content-Type: application/json' -d '{
  "revision": {
    "clientId": "'${clientId}'",
    "version": 0
  },
  "component": {
    "type": "org.apache.nifi.processors.standard.LogAttribute",
    "name": "LogAttribute",
    "position": {
      "x": 300,
      "y": -100
    }
  }
}'  http://"${nifi_host}":"${nifi_port}"/nifi-api/process-groups/${pg_id}/processors | jq -c '.id'| tr -d '"'`
```


### Create Connection Between Generate Flow File and LogAttribute
```
export Connection_GenerateFlowFile_LogAttribute_id=`
curl -XPOST -H 'Content-Type: application/json' -d '{
  "revision": {
    "clientId": "'${clientId}'",
    "version": 0
  },
  "component": {
    "name": "",
    "source": {
      "id": "'${GenerateFlowFile_id}'",
      "groupId": "'${pg_id}'",
      "type": "PROCESSOR"
    },
    "destination": {
      "id": "'${LogAttribute_id}'",
      "groupId": "'${pg_id}'",
      "type": "PROCESSOR"
    },
    "selectedRelationships": [
      "success"
    ],
    "flowFileExpiration": "0 sec",
    "backPressureDataSizeThreshold": "1 GB",
    "backPressureObjectThreshold": "10000",
    "bends": [],
    "prioritizers": []
  }
}'  http://"${nifi_host}":"${nifi_port}"/nifi-api/process-groups/"${pg_id}"/connections | jq -c '.id'| tr -d '"'`
```



### Disable Log Attribute 
### First Capture Processor Revision version Value
```
export pg_revision_version=`curl -XGET http://${nifi_host}:${nifi_port}/nifi-api/processors/"${LogAttribute_id}" | jq -c '.revision.version'`

curl -XPUT -H 'Content-Type: application/json' -d '{
  "revision": {
    "clientId": "'${clientId}'",
    "version": '${pg_revision_version}'
  },
  "component": {
    "id": "'${LogAttribute_id}'",
    "state": "DISABLED"
  }
}' http://"${nifi_host}":"${nifi_port}"/nifi-api/processors/"${LogAttribute_id}"
```

### Start / Run the GenerateFlowFile Processor
#### First Capture Processor Revision version Value
```
export pg_revision_version=`curl -XGET http://${nifi_host}:${nifi_port}/nifi-api/processors/"${GenerateFlowFile_id}" | jq -c '.revision.version'`

curl -XPUT -H 'Content-Type: application/json' -d '{
  "revision": {
    "clientId": "'${clientId}'",
    "version": '${pg_revision_version}'
  },
  "component": {
    "id": "'${GenerateFlowFile_id}'",
    "state": "RUNNING"
  }
}' http://"${nifi_host}":"${nifi_port}"/nifi-api/processors/"${GenerateFlowFile_id}"
```


### Stop GenerateFlowFile Processor
#### First Capture Processor Revision version Value
```
export pg_revision_version=`curl -XGET http://${nifi_host}:${nifi_port}/nifi-api/processors/"${GenerateFlowFile_id}" | jq -c '.revision.version'`

curl -XPUT -H 'Content-Type: application/json' -d '{
  "revision": {
    "clientId": "'${clientId}'",
    "version": '${pg_revision_version}'
  },
  "component": {
    "id": "'${GenerateFlowFile_id}'",
    "state": "STOPPED"
  }
}' http://"${nifi_host}":"${nifi_port}"/nifi-api/processors/"${GenerateFlowFile_id}"
```


### Empty all data from a Connection Queue  
```
curl -X POST http://"${nifi_host}":"${nifi_port}"/nifi-api/flowfile-queues/"${Connection_GenerateFlowFile_LogAttribute_id}"/drop-requests
```
### Stop all the Components in the Processor Group 
```
curl -XPUT -H 'Content-Type: application/json' -d '{"id":"'${pg_id}'","state":"STOPPED"}'  http://"${nifi_host}":"${nifi_port}"/nifi-api/flow/process-groups/"${pg_id}"
```