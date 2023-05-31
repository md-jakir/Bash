#!/bin/bash

# Set the name of your S3 bucket
bucket_name="s3_bucket_name"

# Set the name of the folder containing the objects you want to delete
folder_name="forlder_1"

# Get the current time in epoch format
current_time=$(date +%s)

# Set the time limit to 7 days ago
time_limit=$(($current_time - 604800))

# Loop through each object in the folder and check its modified time
for object_key in $(/usr/local/bin/aws s3api list-objects --bucket $bucket_name --prefix $folder_name/ --query 'Contents[].Key' --output text); do
  if [ "$object_key" != "$folder_name/" ]; then
    modified_time=$(/usr/local/bin/aws s3api head-object --bucket $bucket_name --key $object_key --query 'LastModified' --output text)
    modified_time=$(date -d "$modified_time" +%s)

    # If the object was modified more than 7 days ago, delete it
    if [ $modified_time -lt $time_limit ]; then
      echo "Deleting $object_key"
      /usr/local/bin/aws s3api delete-object --bucket $bucket_name --key $object_key
    fi
  fi
done
