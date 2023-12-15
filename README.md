# spark-ec2-deployer

Contains script for deploying an EC2 instance with a file system and custom Spark application. The Spark application is built to integrate with AWS data services - S3 & Glue - to easily mange databases, and extract and load data.
As a side note, an EMR cluster would do all of this for us, but it is expensive so this helps to get started for free (if you opt for EC2 free tier instance) while getting the benefits of remote development.
