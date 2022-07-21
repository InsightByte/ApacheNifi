## Setup NiFi Monitoring with Prometheus and Grafana


#### Edit the Prometheus yml
```
global:
  scrape_interval:     10s # By default, scrape targets every 15 seconds.
scrape_configs:
  - job_name: 'NiFi'
    scrape_interval: 5s
    static_configs:
      - targets: ['host.docker.internal:9092'] 
```
- this is how my looks like, i am using docker on mac m1 - so that is why i have to use the `host.docker.internal`


#### Build Prometheus image
```
cd ApacheNifi/Monitor-NiFi-with-Prometheus-and-Grafana/config
docker build -t nifi-prometheus .
```

#### Run Prometheus container
```
docker run \
    -d \
    --name prometheus \
    -p 9090:9090 \
    nifi-prometheus
```



docker run \
--name=monitofi1 \
--network=host -d \
-e INFLUXDB_SERVER="influxdb-grafana" \
-e ENDPOINT_LIST="controller/cluster,flow/cluster/summary,flow/process-groups/root,flow/status,counters,system-diagnostics" \
-e SLEEP_INTERVAL=300 \
-e API_URL='http://localhost:8081/nifi-api/' \
--restart unless-stopped \
dtushar/monitofi:latest
