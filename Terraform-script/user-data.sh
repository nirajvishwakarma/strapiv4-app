#! /bin/bash
sudo apt update
sudo apt install default-jre -y
sudo apt install default-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins 
sudo cat /var/lib/jenkins/secrets/initialAdminPassword >password.txt
## install Docker ##
sudo apt install docker.io -y
sudo chmod 777 /var/run/docker.sock
## Install AWS CLI ##
sudo apt install awscli -y
## Install kubectl ##
{
   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
   echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
}
sudo apt update && sudo apt install -y kubectl=1.23.1-00
## Install nodejs ##
sudo apt install curl
cd ~
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt -y install nodejs
