#!/bin/bash

sudo chown ec2-user:ec2-user /init_setup_assets/spark-ec2-deployer/scripts/env.sh
source /init_setup_assets/spark-ec2-deployer/scripts/env.sh

# Mount S3 bucket to local directory
for bucket in "${S3_BUCKET_NAMES[@]}"; do
  # Create target directory in EC2
  sudo mkdir /repository
  sudo mkdir /repository/${bucket}
  sudo chown ec2-user:ec2-user /repository

  # Mount S3 bucket to target directory
  sudo s3fs "${bucket}" "/repository/${bucket}" -o iam_role=auto -o allow_other -o uid=1001 -o mp_umask=002 -o multireq_max=5 -o use_path_request_style -o url=https://s3.us-east-2.amazonaws.com -o endpoint=us-east-2
done

