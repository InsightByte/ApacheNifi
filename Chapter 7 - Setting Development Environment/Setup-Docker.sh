
Login into your instance
ssh -i "/Users/adrianoprea/Desktop/InsightByte/GitRepo/InsightByte_demo.pem" ubuntu@$public_ip

################ Install Docker
sudo apt update -y
sudo apt upgrade -y 
sudo apt-get install curl apt-transport-https ca-certificates software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install docker-ce -y 
sudo systemctl status docker
sudo su 




# set base baseUrl to all 


session set nifi.props /opt/nifi-toolkit/nifi-envs/nifi-dev



stage('Run NiFi'){
    steps {
        script {
            sh('/opt/nifi-toolkit/bin/cli.sh session set nifi.props /opt/nifi-toolkit/nifi-envs/nifi-dev && /opt/nifi-toolkit/bin/cli.sh nifi get-root-it')
        }
    }
}
stage('Run Registry'){
    steps {
        script {
            sh('/opt/nifi-toolkit/bin/cli.sh session set nifi.reg.props /opt/nifi-toolkit/nifi-envs/registry-prd && /opt/nifi-toolkit/bin/cli.sh registry list-buckets')
        }
    }
}






# CREATE Registry client entires on all nifi instalations
nifi create-reg-client --baseUrl http://<public_ip_of_nifi>:8080 --registryClientUrl http://<private_ip_of_registry>:18080 --registryClientName PRD
