## Setup NiFi Monitoring with Prometheus and Grafana

![](https://i.imgur.com/waxVImv.png)
#### 💬 If you have Questions or wanna have a chat - Join Me on Discord at:
[Apache NiFi Topics Q&A](https://discord.gg/qymAvnZqmQ)

[Data Engineering Topics Q&A](https://discord.gg/YykpUT5Wt2)

[Data Engineering  Compass Q&A](https://discord.gg/XR3JqUrA74)

![](https://i.imgur.com/waxVImv.png)


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
