
![](https://github.com/InsightByte/ApacheNifi/blob/main/NiFi-on-AWS/Kinesis/assets/aws-kinesis.png)

#### Apache NiFi Template location 
[Link](https://github.com/InsightByte/ApacheNifi/blob/main/NiFi-on-AWS/Kinesis/assets/kinesis.xml)


#### Find the Youtube tutorial here [Link](https://youtu.be/doaCJHJ4rB0)
#### Create the AWS Kinesis Stream
```
aws kinesis create-stream --stream-name 'my-demo-stream' --shard-count 1
```

#### Clean AWS Kinesis Strema Resources
```
aws kinesis delete-stream --stream-name 'my-demo-stream'
```
![](https://i.imgur.com/waxVImv.png)

#### Create AWS Firehose Resources

```
export aws_account_id=`aws sts get-caller-identity --output text | awk {'print $1'}`

# Create S3 Bucket 
aws s3 mb s3://demo-insigthbyte --no-cli-pager

# Create Role 
aws iam create-role --role-name Firehose-Role --assume-role-policy-document file://iam-role.json --no-cli-pager

# Create Policy 
aws iam create-policy --policy-name "access_to_kinesis" \
 --description "An IAM policy that allows access to a specific Kinesis Firehose." \
 --policy-document file://iam-policy.json --no-cli-pager

# Attach Policy to Role 
aws iam attach-role-policy --policy-arn arn:aws:iam::${aws_account_id}:policy/access_to_kinesis --role-name Firehose-Role --no-cli-pager

# Create Delivery Stream
aws firehose create-delivery-stream \
   --delivery-stream-name 'my-delivery-stream' \
   --s3-destination-configuration \
  '{"RoleARN":"arn:aws:iam::'${aws_account_id}':role/Firehose-Role", "BucketARN": "arn:aws:s3:::demo-insigthbyte"}' --no-cli-pager
```


#### Clean AWS Firehose Resources
```
export aws_account_id=`aws sts get-caller-identity --output text | awk {'print $1'}`

# Detach Policy from role 
aws iam detach-role-policy --policy-arn arn:aws:iam::${aws_account_id}:policy/access_to_kinesis --role-name Firehose-Role --no-cli-pager

# Delete Policy
aws iam delete-policy --policy-arn arn:aws:iam::${aws_account_id}:policy/access_to_kinesis

# Delete Role 
aws iam delete-role --role-name Firehose-Role

# Delete Kinesis Firehose
aws firehose delete-delivery-stream --delivery-stream-name 'my-delivery-stream'

# Empty bucket and delete
aws s3 rb s3://demo-insigthbyte --force 
```
