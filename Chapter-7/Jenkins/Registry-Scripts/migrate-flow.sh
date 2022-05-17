#!/bin/bash

#Migrates flow from one environment to another
#Exit if any command fails
set -e
# Read agruments
version="$1"
target_env="$2"
#Set Global Defaults
[ -z "$FLOW_NAME" ] && FLOW_NAME="ConvertCSV2JSON"
case "$target_env" in
prod)
    PROD_PROPS="./env/nifi-prod.properties";;
*)
    echo "Usage: $(basename "$0")   "; exit 1;;
esac
echo "Migrating flow '${FLOW_NAME}' to environment ${target_env}"
echo "==============================================================="
echo -n "Listing NiFi registry buckets......"
bucket_id=$(./nifi-toolkit-1.13.2/bin/cli.sh registry list-buckets -ot json 
-p "./env/nifi-registry.properties" | jq '.[0].identifier')
echo "[\033[0;32mOK\033[0m]"
echo -n "Listing NiFi registry flows........"
flow_id=$(./nifi-toolkit-1.13.2/bin/cli.sh registry list-flows -b ${bucket_id} -ot json 
-p "./env/nifi-registry.properties" | jq '.[0].identifier')
echo "[\033[0;32mOK\033[0m]"
echo -n "Deploying flow ${FLOW_NAME} to environment ${target_env}......."
./nifi-toolkit-1.13.2/bin/cli.sh nifi pg-import -b ${bucket_id} -f ${flow_id} -fv ${version} 
-p "$PROD_PROPS" > /dev/null
echo "[\033[0;32mOK\033[0m]"
echo "Flow deployment to environment ${target_env} successfully finished!"
exit 0


pipeline {
  agent any
  parameters {
      choice(name: 'REGISTRY_ENV', description: 'Registry Enviroment', choices: 'dev\nstg\nprd')
      string(name: 'BUCKET_NAME', description: 'Bucket Name where Flow is Registered')
      string(name: 'FLOW_NAME', description: 'Flow Name')
      string(name: 'FLOW_VERSION', description: 'Flow Version', default: 'latest')
  }
  stages {
    stage('Create Registry Bucket'){
        steps {
            script {
                sh('/opt/nifi-toolkit/bin/cli.sh session set nifi.reg.props /opt/nifi-toolkit/nifi-envs/registry-${REGISTRY_ENV} && /opt/nifi-toolkit/bin/cli.sh registry create-bucket --bucketName ${BUCKET_NAME} --bucketDesc ${BUCKET_DESC} ')
            }
        }
    }
  }
}
