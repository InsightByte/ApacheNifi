registry create-bucket --bucketName ${bucketName} --bucketDesc ${bucketDesc} --outputType json




export bucketName='"test"'
export json=`/opt/nifi-toolkit/bin/cli.sh registry list-buckets -ot json`

i=1
for bkt in `echo "$json" | jq -c '.[] | .name '`;
 do 
 if [[ $bkt == $bucketName ]]; 
    then echo "BucketName $bkt, is already in use."; i+=1;
 fi;
done
echo $i
echo "BucketName $bucketName, created."

/opt/nifi-toolkit/bin/cli.sh registry create-bucket --bucketName test -ot json




echo `echo "$json" | jq -c '.[] | .name '` | grep -w -q $bucketName
