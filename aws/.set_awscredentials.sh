#!/bin/bash

AWS_CREDENTIALS_FILE="/home/rickk/.aws/credentials"
AWS_S3CMD_FILE="/home/rickk/.s3cfg"

sed -i "/^aws_access_key_id.*/d" $AWS_CREDENTIALS_FILE
sed -i "/^aws_secret_access_key.*/d" $AWS_CREDENTIALS_FILE

echo "aws_access_key_id = ${AWS_ACCESS_KEY}" >> $AWS_CREDENTIALS_FILE
echo "aws_secret_access_key = ${AWS_ACCESS_SECRET_KEY}" >> $AWS_CREDENTIALS_FILE

sed -i "/^access_key.*/d" $AWS_S3CMD_FILE
sed -i "/^secret_key.*/d" $AWS_S3CMD_FILE

echo "access_key = ${AWS_ACCESS_KEY}" >> $AWS_S3CMD_FILE
echo "secret_key = ${AWS_ACCESS_SECRET_KEY}" >> $AWS_S3CMD_FILE

#Setting global variables 
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
#export AWS_DEFAULT_REGION=$AWS_REGION
