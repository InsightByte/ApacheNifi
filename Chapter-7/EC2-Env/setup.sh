## You must have an AWS Account and aws cli installed locally.
## If you haven`t done it yet follow this tutorial on how you can do it.



### Setting some parameters
ApacheNifi/Chapter-7/EC2-Env/config.sh


### !!!! Delete all resource if they exists
aws ec2 delete-key-pair --key-name ${key_name} --no-cli-pager
export instance_id=`aws ec2 describe-instances --filters 'Name=tag:Name,Values=DemoNiFi' --output text --query 'Reservations[*].Instances[*].InstanceId' --filters Name=instance-state-name,Values=running`
if [ -z "$instance_id" ]
then
      echo "No EC2 running for DemoNiFi Tag"
else
      echo "Will terminate \$instance_id"
      aws ec2 terminate-instances --instance-ids ${instance_id}  --no-cli-pager
      sleep 60
      echo "Removing SG DemoNiFi"
      aws ec2 delete-security-group --group-name DemoNiFi --no-cli-pager
fi
export allocation_id=`aws ec2 describe-addresses --filters "Name=tag-value,Values=DemoNiFi" | jq -r '.Addresses[0].AllocationId'`
if [ -n "$allocation_id" ]
then
      echo "No EIP for DemoNiFi Tag"
else
      echo "Release EIP"
      aws ec2 release-address --allocation-id  ${allocation_id} --no-cli-pager
fi

#### Create new ec2 Key
echo "Generate Key $key_name"
rm -f $key_name.pem 
aws ec2 create-key-pair --key-name $key_name --query 'KeyMaterial' --output text > $key_name.pem 
chmod 400 $key_name.pem

#### Get the public subnet id
export subnets=$(aws ec2 describe-subnets --filter Name=vpc-id,Values=$vpc_id --query 'Subnets[?MapPublicIpOnLaunch==`true`].SubnetId') 
export subnet_id=`echo $subnets | jq -r '.[0]'`

#### Create a Security Group
export sg_id=`aws ec2 create-security-group --group-name DemoNiFi --description "SG used for Demo NiFi" --vpc-id $vpc_id --output text`

#### Create EIP and tag it
export eip=`aws ec2 allocate-address` 
export public_ip=`echo $eip| jq -r '.PublicIp'`
export allocation_id=`echo $eip| jq -r '.AllocationId'`
aws ec2 create-tags --resources $allocation_id --tags Key='Name',Value='DemoNiFi' Key='Owner',Value='InsightByte' --no-cli-pager


#### find my local ip and add an ingress rule to allow all coming from your ip
export local_ip=`dig +short myip.opendns.com @resolver1.opendns.com`
export add_sg1=`aws ec2 authorize-security-group-ingress --group-name DemoNiFi --protocol all --port all --cidr $local_ip/32 --no-cli-pager`
export add_sg2=`aws ec2 authorize-security-group-ingress --group-name DemoNiFi --protocol all --port all --cidr $public_ip/32 --no-cli-pager`

#### create EC2 instance
echo "Create EC2"
export ec2=`aws ec2 run-instances --image-id $ami --count 1 --instance-type $instance_type --key-name $key_name --security-group-ids $sg_id --subnet-id $subnet_id --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=DemoNiFi}]' --block-device-mapping "[ { \"DeviceName\": \"/dev/sda1\", \"Ebs\": { \"VolumeSize\": 100 } } ]"`
export ec2_id=`echo $ec2 | jq -r '.Instances[0].InstanceId'`

sleep 20
echo "Associate Public Ip"
#### Associate the Ip with our instance
aws ec2 associate-address --instance-id $ec2_id --allocation-id $allocation_id --no-cli-pager




##################### Building Resource #######################################
### if running in a single step ou might need to wait 5 min before you ec2 is up and running 
echo "Will wait for 30 sec - to make sure the EC2 is up and running"
sleep 30

## Copy the scripts to the EC2 box
## Make sure you are in the scripts folder of your repo
echo "Copy scripts folder content to ec2"
scp -i $key_name.pem ApacheNifi/Chapter-7/EC2-Env/scripts/*.sh ubuntu@$public_ip:~/.
ssh -i $key_name.pem ubuntu@$public_ip 'sudo mkdir -p /opt/scripts && sudo mv ~/*.sh /opt/scripts && sudo chmod 775 /opt/scripts/*.sh'


## Login into your instance
echo "Install Docker"
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-Docker.sh'
sleep 30 

echo "Setup Jenkins"
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-Jenkins.sh' 
sleep 30

echo "Setup NiFi Registry" 
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-NiFi-Registry.sh'

echo "Setup NiFi PRD/STG/DEV"
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-NiFi.sh'
echo "Wait for 300 sec"
sleep 300

### You should wait for NiFi Services to be available and then run this cmd
echo "Setup NiFi Registry Clients"
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/run-Setup-Registry-Client.sh'

echo "Setup Complete"
echo "You will need to complete Jenkins pluginc setup @ http://$public_ip:8888 using the Admin Password provided after Setup Jenkins step".
echo "NiFi Registry is available @ http://$public_ip:18080/nifi-registry"
echo "NiFi PRD is available @ http://$public_ip:8080/nifi"
echo "NiFi STG is available @ http://$public_ip:8081/nifi"
echo "NiFi DEV is available @ http://$public_ip:8082/nifi"

