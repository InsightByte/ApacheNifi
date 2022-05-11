#### Find the Instance Id using the Instance Name
export instance_id=`aws ec2 describe-instances --filters 'Name=tag:Name,Values=DemoNiFi' --output text --query 'Reservations[*].Instances[*].InstanceId'`
#### Stop Instance
aws ec2 stop-instances --instance-ids ${instance_id} --no-cli-pager



#### Find the Instance Id using the Instance Name
export instance_id=`aws ec2 describe-instances --filters 'Name=tag:Name,Values=DemoNiFi' --output text --query 'Reservations[*].Instances[*].InstanceId'`
#### Start Instance 
aws ec2 start-instances --instance-ids ${instance_id} --no-cli-pager