#! /bin/bash

#execute this script with admin permissions

#the script is executed as:   sudo ./install_docker.sh $USER

#This script is meant to automate the installation of docker 

#sets the script to exit if one command fails
set -e

#Uninstalls old versions of docker installed, if any.

apt-get remove docker docker.io containerd runc

#updating apt

apt-get update

#installing packages to allow the use of a repository over https

apt-get install -y  apt-transport-https  ca-certificates  curl gnupg-agent software-properties-common

#adding docker oficial gpg key

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#verifying the fingerprint


if [ $(apt-key fingerprint 0EBFCD88) ]
then
	echo "The fingerprint is incorrect, verify you are adding the docker oficial gpg key"
	exit 
fi

#setting the stable repository

add-apt-repository  "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#updating the repository

apt-get update

#installing docker

apt-get install -y docker-ce docker-ce-cli containerd.io

#adding the user to the docker group

usermod -aG docker $1


#Ask the user if he wants to install docker-compose

read -p "Install docker-compose as well? (y/n): " ANSWER

if [ "${ANSWER}"=='y' ] || [ "${ANSWER}" == 'Y' ]
then
	curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose
	echo "Docker-compose installed"
fi


