

################ Run NiFi Registry Container

docker run --restart always --name nifi-registry \
  -p 18080:18080 \
  -d \
  apache/nifi-registry:latest

### Open Web browser @
http://$public_ip:18080/nifi-registry

