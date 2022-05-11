#!/bin/bash
set +x

################ Run NiFi Registry Container

docker run --restart always --name nifi-registry \
  -p 18080:18080 \
  -d \
  apache/nifi-registry:latest

export public_ip=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`

### Open Web browser @
echo "NiFi Registry is available @ http://"$public_ip":18080/nifi-registry" 

