
# Ubuntu image we will use
export ami='ami-0672b175139a0f8f4'

# My VPC 
export vpc_id='vpc-d2af15b7' 

# Instance Type/Size
export instance_type='t3.xlarge'

# My Key name
export key_name='InsightByte_demo'

echo "\n"
echo "Will run AMI "$ami" on VPC "$vpc_id" using instance type "$instance_type" with key "$key_name
echo "\n"
