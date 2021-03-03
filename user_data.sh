#!/bin/bash

# Update Ubuntu
apt-get update -y

# Install Docker
apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt update -y
apt install -y docker-ce docker-ce-cli containerd.io
usermod -aG docker ubuntu

# Install Docker-Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
systemctl enable docker
curl -Lfo /home/ubuntu/docker-compose.yaml 'https://airflow.apache.org/docs/apache-airflow/2.0.1/docker-compose.yaml' 
mkdir /home/ubuntu/dags /home/ubuntu/logs /home/ubuntu/plugins
chmod -R 777 /home/ubuntu/dags
chmod -R 777 /home/ubuntu/logs
chmod -R 777 /home/ubuntu/plugins
echo -e "AIRFLOW_UID=$(id -u)\nAIRFLOW_GID=0" > /home/ubuntu/.env
echo "Primeiro Compose"
docker-compose -f /home/ubuntu/docker-compose.yaml up airflow-init
echo "Segundo Compose"
docker-compose -f /home/ubuntu/docker-compose.yaml up -d
echo "Done!!!!"