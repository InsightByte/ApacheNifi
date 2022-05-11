
#!/bin/bash
set +x
################ Run NiFi containers
export public_ip=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`


docker pull apache/nifi


docker run --restart always \
  -d --name "nifi-PRD" \
  -p 8080:8080 \
  -p 8443:8443 \
  -p 10000:10000 \
  -p 8000:8000 \
  -p 8181:8181 \
  -e NIFI_WEB_HTTP_PORT='8080' \
  -e NIFI_WEB_HTTPS_HOST='' \
  -e NIFI_WEB_HTTPS_PORT='' \
  "apache/nifi:latest"

docker run --restart always \
  -d --name "nifi-STG" \
  -p 8081:8081 \
  -p 8444:8443 \
  -p 10001:10000 \
  -p 8001:8000 \
  -p 8182:8181 \
  -e NIFI_WEB_HTTP_PORT='8081' \
  -e NIFI_WEB_HTTPS_HOST='' \
  -e NIFI_WEB_HTTPS_PORT='' \
  "apache/nifi:latest"

docker run --restart always \
  -d --name "nifi-DEV" \
  -p 8082:8082 \
  -p 8445:8443 \
  -p 10002:10000 \
  -p 8002:8000 \
  -p 8183:8181 \
  -e NIFI_WEB_HTTP_PORT='8082' \
  -e NIFI_WEB_HTTPS_HOST='' \
  -e NIFI_WEB_HTTPS_PORT='' \
  "apache/nifi:latest"

echo "### Open Web browser for nifi-PRD @ http://"$public_ip":8080/nifi" 
echo "### Open Web browser for nifi-STG @ http://"$public_ip":8081/nifi" 
echo "### Open Web browser for nifi-DEV @ http://"$public_ip":8082/nifi" 
