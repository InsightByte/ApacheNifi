
How to install AWS CLI 
Offical AWS documentation https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

demonifi508@gmail.com

curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /


aws --version 


## Setup Access next using aws key 
# Navigate to ~/.aws/

# create this two files 

# config
[default]
region = ap-southeast-2 --> default region
output = json  --> default output

# credentials
[default]
aws_access_key_id = "your key"
aws_secret_access_key = "your key"


## Test command 
aws ec2 describe-instances 