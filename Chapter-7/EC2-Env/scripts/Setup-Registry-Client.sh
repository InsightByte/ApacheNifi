#!/bin/bash
set +x

### Once all services are up setup Registry Client Entry on all nifi instalations
### This must run againt the Jenkins container where we have installed the nifi toolkit
export public_ip=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`

echo "### Adding Registry Client to PRD"
/opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://$public_ip:8080 --registryClientUrl http://$public_ip:18080 --registryClientName PRD
echo "### Adding Registry Client to STG"
/opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://$public_ip:8081 --registryClientUrl http://$public_ip:18080 --registryClientName PRD
echo "### Adding Registry Client to DEV"
/opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://$public_ip:8082 --registryClientUrl http://$public_ip:18080 --registryClientName PRD
