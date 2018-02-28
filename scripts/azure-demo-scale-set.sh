#!/bin/bash

# Configure Environment Variables
echo "PORT=80" >> /etc/environment
echo "STATUS=200" >> /etc/environment
echo "AZURE_STORAGE_ACCOUNT=$1" >> /etc/environment
echo "AZURE_STORAGE_ACCESS_KEY=$2" >> /etc/environment

export "PORT=80"
export "STATUS=200"
export "AZURE_STORAGE_ACCOUNT=$1"
export "AZURE_STORAGE_ACCESS_KEY=$2"

# Configure Script Variables
path="/ans"
gitAccount="nathanguk"
gitRepo="azure-demo-gallery-linux"
service="azuredemogallery"

#Update Server
apt-get update -y
apt-get upgrade -y

# Download and install Node.JS
curl -sL https://deb.nodesource.com/setup_8.x | bash -
apt-get install -y nodejs

# Install Unzip
apt-get install -y unzip

# Download and unzip application files
mkdir $path
resourcePath="/$gitAccount/$gitRepo/archive/master.zip"
url="https://github.com$resourcePath" 

curl -sL $url -o "/$path/master.zip"
unzip "$path/master.zip" -d $path

npm install node-linux --prefix "$path/$gitRepo-master"
npm install --prefix "$path/$gitRepo-master"
node "$path/$gitRepo-master/service.js"

service $service start