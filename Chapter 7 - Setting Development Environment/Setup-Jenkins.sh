
################ Run Jenkins Container

docker run --name jenkins -d -p 8888:8080 -p 50000:50000 --restart always jenkins/jenkins:lts-jdk11
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword








apt-get update && apt install wget
cd /opt
wget https://dlcdn.apache.org/nifi/1.16.1/nifi-toolkit-1.16.1-bin.zip
unzip nifi-toolkit-1.16.1-bin.zip
mv nifi-toolkit-1.16.1 nifi-toolkit
rm -rf nifi-toolkit-1.16.1-bin.zip



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

### Open Web browser @
http://$public_ip:8080

And go thru setting your Jenkins installation.




# NiFi Jenkins 


export PUBLIC_IP=`curl http://checkip.amazonaws.com`
# install nifi toolkit onto Jenkins 
echo "Your Jenkins Initial Admin Password is:"
docker exec recursing_blackburn /bin/sh -c "cat /var/jenkins_home/secrets/initialAdminPassword"
echo "Go to : http://"${PUBLIC_IP}":8080" and setup Jenkins 


