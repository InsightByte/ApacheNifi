#### Find the Instance Id using the Instance Name
export instance_id=`aws ec2 describe-instances --filters 'Name=tag:Name,Values=DemoNiFi' --output text --query 'Reservations[*].Instances[*].InstanceId'`
#### Stop Instance
aws ec2 stop-instances --instance-ids ${instance_id} --no-cli-pager



#### Find the Instance Id using the Instance Name
export instance_id=`aws ec2 describe-instances --filters 'Name=tag:Name,Values=DemoNiFi' --output text --query 'Reservations[*].Instances[*].InstanceId'`
#### Start Instance 
aws ec2 start-instances --instance-ids ${instance_id} --no-cli-pager


# In Case you restart your terminal and you loose the public_ip values run this 
export public_ip=`aws ec2 describe-addresses --filters "Name=tag-value,Values=DemoNiFi" | jq -r '.Addresses[0].PublicIp'`
export key_name='InsightByte_demo'

