#!/bin/bash

echo "Publishing an index.html in AWS"

echo "Checking if AWS ENV variables are set"
[ -z "$AWS_ACCESS_KEY_ID" ] && echo "Need to set AWS_ACCESS_KEY_ID" && exit 1;
[ -z "$AWS_SECRET_ACCESS_KEY" ] && echo "Need to set AWS_SECRET_ACCESS_KEY" && exit 1;
[ -z "$AWS_DEFAULT_REGION" ] && echo "Need to set AWS_DEFAULT_REGION" && exit 1;

echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
echo "AWS_SECRET_ACCESS_KEY: Not showing you that!"
echo "AWS_DEFAULT_REGION: $AWS_DEFAULT_REGION"
echo "Checking if AWS CLI is installed"
command -v aws >/dev/null 2>&1 || { echo >&2 "I require aws but it's not installed.  Aborting."; exit 1; }
echo "IAM Get User"
aws iam get-user

echo "Creating the S3 bucket"

echo "Copying the website into the bucket"

#aws s3 cp build s3://<Your bucket name>/<Your folder name> --acl public-read --recursive