# Login to AWS SSO based on profile in ~/.aws/config
#aws sso login --profile default

# Get Env Variables
source env.sh

# Launch EC2 instance
# Create security group
DESCRIPTION="Security group for developer SSH access to ec2 instance"
if ! aws ec2 describe-security-groups --group-names "$SECURITY_GROUP_NAME" --region "$REGION" >/dev/null 2>&1; then
  SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name "$SECURITY_GROUP_NAME" --description "$DESCRIPTION" --region "$REGION" --output text --query 'GroupId')
  echo "Created security group with ID: $SECURITY_GROUP_ID"

  # Add inbound rule to allow SSH access
  aws ec2 authorize-security-group-ingress --group-id "$SECURITY_GROUP_ID" --protocol tcp --port 22 --cidr 0.0.0.0/0 --region "$REGION"
else
  echo "Security group $SECURITY_GROUP_NAME already exists"
    SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --group-names "$SECURITY_GROUP_NAME" --region "$REGION" --query 'SecurityGroups[0].GroupId' --output text)
    echo "Using existing security group with ID: $SECURITY_GROUP_ID"
fi

# Create key pair
if ! aws ec2 describe-key-pairs --key-names "$KEY_PAIR_NAME" --region "$REGION" >/dev/null 2>&1; then
  aws ec2 create-key-pair --key-name "$KEY_PAIR_NAME" --region $REGION --query 'KeyMaterial' --output text > $KEY_PAIR_NAME.pem
  chmod 400 "$KEY_PAIR_NAME.pem"
  echo "Created key pair: $KEY_PAIR_NAME.pem"
else
  echo "Key pair $KEY_PAIR_NAME already exists"
fi

# Create IAM instance profile
if ! aws iam get-instance-profile --instance-profile-name "$IAM_INSTANCE_PROFILE" --region "$REGION" >/dev/null 2>&1; then
  aws iam create-instance-profile --instance-profile-name "$IAM_INSTANCE_PROFILE" --region $REGION
  echo "Created IAM instance profile: $IAM_INSTANCE_PROFILE"
else
    echo "IAM instance profile $IAM_INSTANCE_PROFILE already exists"
fi

# Launch a new EC2 instance
INSTANCE_ID=$(aws ec2 run-instances --instance-type "$INSTANCE_TYPE" --image-id "$IMAGE_ID" --key-name "$KEY_PAIR_NAME" --security-group-ids "$SECURITY_GROUP_ID" --iam-instance-profile Name="$IAM_ROLE_NAME" --user-data file://"${REMOTE_CONFIG_FILE}" --output text --query 'Instances[0].InstanceId')
echo "New instance launched with ID: $INSTANCE_ID"

# Wait for instance to be running
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region $REGION
echo "Instance is now running"

export INSTANCE_ID="$INSTANCE_ID"


# SSH into EC2 instance
PUBLIC_DNS=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query 'Reservations[0].Instances[0].PublicDnsName' --output text)

ssh -i "${KEY_PAIR_NAME}.pem" ec2-user@"$PUBLIC_DNS" 'bash /init_setup_assets/spark-ec2-deployer/scripts/config_ec2/config_ec2.sh'





