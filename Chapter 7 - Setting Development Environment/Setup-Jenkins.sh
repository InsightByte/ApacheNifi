#!/bin/bash
set +x
################ Run Jenkins Container

export public_ip=`curl -s http://169.254.169.254/latest/meta-data/public-ipv4`

sudo docker run --name jenkins -d -p 8888:8080 -p 50000:50000 --restart always jenkins/jenkins:lts-jdk11
# Get Initial Admin Password
sleep 10
echo "##### Jenkins Initial Admin Password  #######"
sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
echo " "
echo "Copy this password and Go to http://"$public_ip":8888 to complete the setup of your Jenkins App" 
sleep 10
echo "####  Setup NiFi Toolkit on Jenkins container ######"
sudo docker cp /opt/scripts/install-toolkit-on-jenkins.sh jenkins:/opt/.
sudo docker exec -u 0 jenkins /opt/install-toolkit-on-jenkins.sh






