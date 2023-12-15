# spark-ec2-deployer

Contains script for deploying an EC2 instance with a file system and custom Spark application. The Spark application is built to integrate with AWS data services - S3 & Glue - to easily manage databases, schedule jobs, and extract / load data.

While an EMR cluster would do all of this, it is expensive so this helps to get started with minimal costs while getting the benefits of AWS integrated remote development. Eventually, this could graduate to a Docker Image or CloudFormation Template.
