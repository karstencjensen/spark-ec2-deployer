#!/bin/bash

# Install software, download scripts from S3, etc...
aws s3 cp s3://spark-ec2-deployer "/init_setup_assets/spark-ec2-deployer" --recursive
chmod +x /init_setup_assets/spark-ec2-deployer/scripts/config_ec2/config_ec2.sh
/init_setup_assets/spark-ec2-deployer/scripts/config_ec2/config_ec2.sh

