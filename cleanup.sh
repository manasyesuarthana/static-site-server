#!/bin/bash

SRV_USER="vagrant"
SRV_ADDRESS="192.168.34.10"

echo "Demobilizing static website and cleaning up artifacts on remote server..."

ssh -i ~/.ssh/id_rsa $SRV_USER@$SRV_ADDRESS "rm -rf /var/www/html/*"
ssh -i ~/.ssh/id_rsa $SRV_USER@$SRV_ADDRESS "sudo systemctl stop nginx; sudo systemctl disable nginx"
ssh -i ~/.ssh/id_rsa $SRV_USER@$SRV_ADDRESS "sudo systemctl stop firewalld; sudo systemctl disable firewalld"
echo
echo "If you wish to re-deploy the website, simply run deploy.sh"