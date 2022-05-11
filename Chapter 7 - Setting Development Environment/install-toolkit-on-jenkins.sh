#!/bin/bash
set +x

echo " Update and Install NiFi Toolkit"
apt-get update -y && apt install wget unzip -y
cd /opt
wget https://dlcdn.apache.org/nifi/1.16.1/nifi-toolkit-1.16.1-bin.zip
unzip nifi-toolkit-1.16.1-bin.zip
mv nifi-toolkit-1.16.1 nifi-toolkit
rm -rf nifi-toolkit-1.16.1-bin.zip

echo "Create NiFi Toolkit Client configuration"
mkdir -p /opt/nifi-toolkit/nifi-envs
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-prd
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-stg
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-dev
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/registry-prd

prop_replace () {
  target_file=${3:-${nifi_props_file}}
  echo 'replacing target file ' ${target_file}
  sed -i -e "s|^$1=.*$|$1=$2|"  ${target_file}
}

export public_ip=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`
prop_replace baseUrl http://$public_ip:8080 /opt/nifi-toolkit/nifi-envs/nifi-prd
prop_replace baseUrl http://$public_ip:8081 /opt/nifi-toolkit/nifi-envs/nifi-stg
prop_replace baseUrl http://$public_ip:8082 /opt/nifi-toolkit/nifi-envs/nifi-dev
prop_replace baseUrl http://$public_ip:18080 /opt/nifi-toolkit/nifi-envs/registry-prd
echo "Toolkit config complete"