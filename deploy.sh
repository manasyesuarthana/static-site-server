#!/bin/bash

#This script fetches the static tooplate template locally then syncs it to the remote server.

SRV_USER="vagrant" #this user is already setup along with its credentials.
SRV_ADDRESS="192.168.34.10" #Note: this is deployed using the vm, it will be inaccessible from a different network.

function log(){
    echo
    echo " ==================== $1 ===================="
    echo
}
set -e

echo
echo "------------------- Starting Web Deployment ---------------------"
echo
log "Generating new SSH key pair without passphrase"
if [ ! -f ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -P "" -q
else
    echo "Existing SSH key found. Skipping key generation."
fi

log "Copying Public Key to remote server."
ssh-copy-id -i ~/.ssh/id_rsa.pub $SRV_USER@$SRV_ADDRESS #enter the password for the user

log "Transferring and running setup.sh remotely."
#transfer and run setup script to the server
scp ./setup.sh $SRV_USER@$SRV_ADDRESS:/tmp/
ssh -i ~/.ssh/id_rsa $SRV_USER@$SRV_ADDRESS "/tmp/setup.sh"
ssh -i ~/.ssh/id_rsa $SRV_USER@$SRV_ADDRESS "rm /tmp/setup.sh"

log "Installing updates and required software"
#updating and installing packages in my own machine
sudo apt update && sudo apt install wget git curl zip unzip -y
mkdir /tmp/webfiles
cd /tmp/webfiles

log "Fetching web files"
wget https://www.tooplate.com/zip-templates/2137_barista_cafe.zip
unzip 2137_barista_cafe.zip

log "Syncing web files to remote server"
#sync web files to server
sudo rsync -ravz --update /tmp/webfiles/2137_barista_cafe/* $SRV_USER@$SRV_ADDRESS:/var/www/html/

rm -rf /tmp/webfiles/

echo
echo "*** Deployment Done! Access the website by entering $SRV_ADDRESS in your local browser! ***"