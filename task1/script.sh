#!/bin/bash

echo "Publishing an index.html in AWS"
echo "Checking if AWS CLI is installed"
command -v aws >/dev/null 2>&1 || { echo >&2 "I require aws but it's not installed.  Please install it Aborting."; exit 1; }

echo "Creating your aws profile"
aws configure --profile task1
#read -p 'Provide your AWS Access Key  : ' AWS_ACCESS_KEY_ID
#read -p 'Provide your AWS Secret : ' AWS_SECRET_ACCESS_KEY
#read -p 'Provide your AWS Region: ' AWS_DEFAULT_REGION
export AWS_PROFILE=task1

echo "creating the keypair to use in the instance, store locally and modify its permissions"
aws ec2 create-key-pair --key-name task1 --query 'KeyMaterial' --output text > task1.pem
chmod 600 task1.pem

echo "Execute the cloudformation script"
aws cloudformation create-stack --stack-name task1 --template-body file://deployindex.yml --parameters ParameterKey=KeyName,ParameterValue=task1 ParameterKey=SSHLocation,ParameterValue=0.0.0.0/0> /dev/null 2>&1

echo "Testing the site going to: "
aws cloudformation describe-stacks --stack-name task1 --query "Stacks[0].Outputs[?OutputKey=='PublicIP'].OutputValue" --output text>PublicIP
