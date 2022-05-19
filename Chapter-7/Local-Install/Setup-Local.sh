export version='1.16.1'
export nifi_registry_port='18080'
export nifi_prd_port='8081'
export nifi_stg_port='8082'
export nifi_dev_port='8083'





cd /opt
wget https://dlcdn.apache.org/nifi/${version}/nifi-${version}-bin.zip
wget https://dlcdn.apache.org/nifi/${version}/nifi-toolkit-${version}-bin.zip
wget https://dlcdn.apache.org/nifi/${version}/nifi-registry-${version}-bin.zip

unzip nifi-${version}-bin.zip -d /opt/nifi-prd && cd  /opt/nifi-prd/nifi-${version} &&  mv * .. && cd .. && rm -rf nifi-${version}
cd /opt
unzip nifi-${version}-bin.zip -d /opt/nifi-stg && cd  /opt/nifi-stg/nifi-${version} &&  mv * .. && cd .. && rm -rf nifi-${version}
cd /opt
unzip nifi-${version}-bin.zip -d /opt/nifi-dev && cd  /opt/nifi-dev/nifi-${version} &&  mv * .. && cd .. && rm -rf nifi-${version}
cd /opt
unzip nifi-toolkit-${version}-bin.zip -d /opt/nifi-toolkit && cd  /opt/nifi-toolkit/nifi-toolkit-${version} &&  mv * .. && cd .. && rm -rf nifi-toolkit-${version}
cd /opt
unzip nifi-registry-${version}-bin.zip -d /opt/nifi-registry && cd  /opt/nifi-registry/nifi-registry-${version} &&  mv * .. && cd .. && rm -rf nifi-registry-${version}
cd /opt


prop_replace () {
  target_file=${3:-${nifi_props_file}}
  echo 'replacing target file ' ${target_file}
  sed -i -e "s|^$1=.*$|$1=$2|"  ${target_file}
}



echo "Create NiFi Toolkit Client configuration"
mkdir -p /opt/nifi-toolkit/nifi-envs
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-PRD
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-STG
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/nifi-DEV
cp /opt/nifi-toolkit/conf/cli.properties.example /opt/nifi-toolkit/nifi-envs/registry-PRD

prop_replace baseUrl http://localhost:${nifi_prd_port} /opt/nifi-toolkit/nifi-envs/nifi-PRD
prop_replace baseUrl http://localhost:${nifi_stg_port} /opt/nifi-toolkit/nifi-envs/nifi-STG
prop_replace baseUrl http://localhost:${nifi_dev_port} /opt/nifi-toolkit/nifi-envs/nifi-DEV
prop_replace baseUrl http://localhost:${nifi_registry_port} /opt/nifi-toolkit/nifi-envs/registry-PRD



# Start NiFi Registry
sudo /opt/nifi-registry/bin/nifi-registry.sh start 


# Edit NiFi configs PRD
prop_replace nifi.web.http.port ${nifi_prd_port} /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.web.https.port ''  /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.web.http.host localhost  /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.web.https.host ''  /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.remote.input.secure false /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.ui.banner.text PRD /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.security.keystore '' /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.security.keystoreType '' /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.security.keystorePasswd '' /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.security.keyPasswd '' /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.security.truststore '' /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.security.truststoreType '' /opt/nifi-prd/conf/nifi.properties
prop_replace nifi.security.truststorePasswd '' /opt/nifi-prd/conf/nifi.properties

# Edit NiFi configs STG
prop_replace nifi.web.http.port ${nifi_stg_port} /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.web.https.port ''  /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.web.http.host localhost  /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.web.https.host ''  /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.remote.input.secure false /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.ui.banner.text STG /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.security.keystore '' /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.security.keystoreType '' /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.security.keystorePasswd '' /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.security.keyPasswd '' /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.security.truststore '' /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.security.truststoreType '' /opt/nifi-stg/conf/nifi.properties
prop_replace nifi.security.truststorePasswd '' /opt/nifi-stg/conf/nifi.properties

# Edit NiFi configs DEV
prop_replace nifi.web.http.port ${nifi_dev_port} /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.web.https.port ''  /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.web.http.host localhost  /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.web.https.host ''  /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.remote.input.secure false /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.ui.banner.text DEV /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.security.keystore '' /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.security.keystoreType '' /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.security.keystorePasswd '' /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.security.keyPasswd '' /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.security.truststore '' /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.security.truststoreType '' /opt/nifi-dev/conf/nifi.properties
prop_replace nifi.security.truststorePasswd '' /opt/nifi-dev/conf/nifi.properties


echo " Start NiFi PRD"
/opt/nifi-prd/bin/nifi.sh start
echo " Start NiFi STG"
/opt/nifi-stg/bin/nifi.sh start
echo " Start NiFi DEV"
/opt/nifi-dev/bin/nifi.sh start




# # Remove Resources 
# rm -f nifi-${version}-bin.zip
# rm -f nifi-toolkit-${version}-bin.zip
# rm -f nifi-registry-${version}-bin.zip


echo "### Adding Registry Client to PRD"
/opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://localhost:${nifi_prd_port} --registryClientUrl http://localhost:${nifi_registry_port} --registryClientName PRD
echo "### Adding Registry Client to STG"
/opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://localhost:${nifi_stg_port}  --registryClientUrl http://localhost:${nifi_registry_port} --registryClientName PRD
echo "### Adding Registry Client to DEV"
/opt/nifi-toolkit/bin/cli.sh nifi create-reg-client --baseUrl http://localhost:${nifi_dev_port}  --registryClientUrl http://localhost:${nifi_registry_port} --registryClientName PRD