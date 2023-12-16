sudo yum update -y
sudo dnf update -y # For Amazon Linux 2023 Machines

sudo chown ec2-user:ec2-user /init_setup_assets/spark-ec2-deployer/scripts/env.sh
source /init_setup_assets/spark-ec2-deployer/scripts/env.sh

# Install Java - required for Pyspark
sudo dnf install java-17-amazon-corretto-devel

# S3FS
sudo yum install -y automake fuse fuse-devel gcc-c++ git libcurl-devel libxml2-devel make openssl-devel
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse || exit
./autogen.sh
./configure --prefix=/usr --with-openssl
make
sudo make install

# Jar files for spark to connect with AWS services (e.g. Glue)
for url in "${spark_aws_dependencies[@]}"
do
  jar_name=$(basename "$url")
  wget "$url" -O /usr/local/spark/jars/"$jar_name"
  sudo chown ec2-user:ec2-user /usr/local/spark/jars/"$jar_name"

  # Add the jar to spark-defaults.conf
  echo "spark.jars += /usr/local/spark/jars/$jar_name" >> /usr/local/spark/conf/spark-defaults.conf
done

echo "hi - ugh!"