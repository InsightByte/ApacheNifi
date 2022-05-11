## You must have an AWS Account and aws cli installed locally.
## If you haven`t done it yet follow this tutorial on how you can do it.



### Setting some parameters

# Ubuntu image we will use
export ami='ami-0672b175139a0f8f4'

# My VPC 
export vpc_id='vpc-d2af15b7' 

# Instance Type/Size
export instance_type='t3.xlarge'

# My Key name
export key_name='InsightByte_demo'


#### Create new ec2 Key
aws ec2 create-key-pair --key-name $key_name --query 'KeyMaterial' --output text > $key_name.pem
chmod 400 $key_name.pem

#### Get the public subnet id
export subnets=$(aws ec2 describe-subnets --filter Name=vpc-id,Values=$vpc_id --query 'Subnets[?MapPublicIpOnLaunch==`true`].SubnetId') 
export subnet_id=`echo $subnets | jq -r '.[0]'`

#### Create a Security Group
export sg_id=`aws ec2 create-security-group --group-name DemoNiFi --description "SG used for Demo NiFi" --vpc-id $vpc_id --output text`

#### find my local ip and add an ingress rule to allow all coming from your ip
export local_ip=`dig +short myip.opendns.com @resolver1.opendns.com`
aws ec2 authorize-security-group-ingress --group-name DemoNiFi --protocol all --port all --cidr $local_ip/32 --no-cli-pager

#### create EC2 instance
export ec2=`aws ec2 run-instances --image-id $ami --count 1 --instance-type $instance_type --key-name $key_name --security-group-ids $sg_id --subnet-id $subnet_id --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=DemoNiFi}]' --block-device-mapping "[ { \"DeviceName\": \"/dev/sda1\", \"Ebs\": { \"VolumeSize\": 100 } } ]"`
export ec2_id=`echo $ec2 | jq -r '.Instances[0].InstanceId'`

#### Create EIP and tag it
export eip=`aws ec2 allocate-address` 
export public_ip=`echo $eip| jq -r '.PublicIp'`
export allocation_id=`echo $eip| jq -r '.AllocationId'`
aws ec2 create-tags --resources $allocation_id --tags Key='Name',Value='DemoNiFi' Key='Owner',Value='InsightByte'

#### Associate the Ip with our instance
aws ec2 associate-address --instance-id $ec2_id --allocation-id $allocation_id --no-cli-pager



# In Case you restart your terminal and oyu loose the public_ip values run this 
export public_ip=`aws ec2 describe-addresses --filters "Name=tag-value,Values=DemoNiFi" | jq -r '.Addresses[0].PublicIp'`
export key_name='InsightByte_demo'

##################### Building Resource #######################################
### if running in a single step ou might need to wait 5 min before you ec2 is up and running 
sleep 300

## Copy the scripts to the EC2 box
## Make sure you are in the scripts folder of your repo
scp -i $key_name.pem install-toolkit-on-jenkins.sh run-Setup-Registry-Client.sh Setup-Registry-Client.sh Setup-Docker.sh Setup-Jenkins.sh Setup-NiFi.sh Setup-NiFi-Registry.sh ubuntu@$public_ip:~/.
ssh -i $key_name.pem ubuntu@$public_ip 'sudo mkdir -p /opt/scripts && sudo mv ~/*.sh /opt/scripts && sudo chmod 775 /opt/scripts/*.sh'


## Login into your instance
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-Docker.sh'
sleep 30 
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-Jenkins.sh'
sleep 30 
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-NiFi-Registry.sh'
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/Setup-NiFi.sh'
sleep 300
### You should wait for NiFi Services to be available and then run this cmd
ssh -i $key_name.pem ubuntu@$public_ip 'sudo /opt/scripts/run-Setup-Registry-Client.sh'


