#!/bin/bash

sudo chown ec2-user:ec2-user /init_setup_assets/spark-ec2-deployer/scripts/env.sh
source /init_setup_assets/spark-ec2-deployer/scripts/env.sh

# Deploy Spark application
sudo chown ec2-user:ec2-user "$REMOTE_SETUP_PATH"/spark-ec2-deployer/scripts/config_ec2/setup_spark.sh
bash "$REMOTE_SETUP_PATH"/spark-ec2-deployer/scripts/config_ec2/setup_spark.sh

# Download dependencies
sudo chown ec2-user:ec2-user "$REMOTE_SETUP_PATH"/spark-ec2-deployer/scripts/config_ec2/download_dependencies.sh
bash "$REMOTE_SETUP_PATH"/spark-ec2-deployer/scripts/config_ec2/download_dependencies.sh

# Mount S3 buckets to EC2 instance
sudo chown ec2-user:ec2-user "$REMOTE_SETUP_PATH"/spark-ec2-deployer/scripts/config_ec2/mount_s3.sh
bash "$REMOTE_SETUP_PATH"/spark-ec2-deployer/scripts/config_ec2/mount_s3.sh

# Delete init setup assets now that we mounted S3
sudo rm -rf "$REMOTE_SETUP_PATH"