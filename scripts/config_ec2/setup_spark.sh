#!/bin/bash

# Download
wget https://downloads.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3.tgz

# Extract
tar -xzf spark-3.5.0-bin-hadoop3.tgz

# Move files
sudo mv spark-3.5.0-bin-hadoop3 /usr/local/spark

# Create spark-defaults.conf file and give access to ec2-user
cp /usr/local/spark/conf/spark-defaults.conf.template /usr/local/spark/conf/spark-defaults.conf
sudo chown ec2-user:ec2-user /usr/local/spark/conf/spark-defaults.conf

# Add spark to env variables
echo "export SPARK_HOME=/usr/local/spark" >> ~/.bashrc
echo "export PATH=\$PATH:\$SPARK_HOME/bin:\$SPARK_HOME/sbin" >> ~/.bashrc

# Reload the updated bashrc file
# shellcheck disable=SC1090
source ~/.bashrc

# Go to Spark UI using the appropriate IP address or hostname of your EC2 instance
echo "You can access the Spark UI at http://18.222.251.0:8080/"
