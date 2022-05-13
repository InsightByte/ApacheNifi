docker run --name jenkins -d -p 8888:8080 -p 50000:50000 --restart always jenkins/jenkins:lts-jdk11


docker run --restart always --name nifi-registry \
  -p 18080:18080 \
  -d \
  apache/nifi-registry:latest


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

sleep 300
docker cp ApacheNifi/Chapter-7/Local-Docker/scripts/install-toolkit-on-jenkins.sh jenkins:/opt/install-toolkit-on-jenkins.sh 
docker exec -u 0 jenkins chmod 777 /opt/install-toolkit-on-jenkins.sh
docker exec -u 0 jenkins /opt/install-toolkit-on-jenkins.sh
sleep 10
export local_ip=`dig +short myip.opendns.com @resolver1.opendns.com`
echo "### Adding Registry Client to PRD"
docker exec -u 0 jenkins /opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://$local_ip:8080 --registryClientUrl http://$local_ip:18080 --registryClientName PRD
echo "### Adding Registry Client to STG"
docker exec -u 0 jenkins /opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://$local_ip:8081 --registryClientUrl http://$local_ip:18080 --registryClientName PRD
echo "### Adding Registry Client to DEV"
docker exec -u 0 jenkins /opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://$local_ip:8082 --registryClientUrl http://$local_ip:18080 --registryClientName PRD

