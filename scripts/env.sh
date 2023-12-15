#!/bin/bash

# EC2 Instance Variables
export REGION="us-east-2"
export INSTANCE_TYPE="t2.micro"
export SECURITY_GROUP_NAME="ssh-spark-ec2-instance"
export KEY_PAIR_NAME="spark-ec2-instance"
export IAM_INSTANCE_PROFILE="EC2_DataAccess"
export IAM_ROLE_NAME="EC2_DataAccess"
export INSTANCE_TYPE="t2.micro"
export IMAGE_ID="ami-06d4b7182ac3480fa"
export REMOTE_CONFIG_FILE="copy_ec2_config_from_s3.sh"
export REMOTE_SETUP_PATH="/init_setup_assets"

# S3 Buckets to Mount to EC2
export S3_BUCKET_NAMES=(
  "spark-ec2-deployer"
)

# JAR File to Deploy
declare -a spark_aws_dependencies=(
  "https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.21.44/bundle-2.21.44.jar"
  "https://repo1.maven.org/maven2/software/amazon/awssdk/url-connection-client/2.21.44/url-connection-client-2.21.44.jar"
  "https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-aws-bundle/1.4.2/iceberg-aws-bundle-1.4.2.jar"
)

export spark_aws_dependencies