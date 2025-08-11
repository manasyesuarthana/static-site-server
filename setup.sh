#!/bin/bash


#this is the script to setup the server.
#note: this script is for CentOS/RHEL Linux distributions.

PACKAGES="wget curl zip unzip nginx epel-release"
SVR_ADDRESS="192.168.34.10"
set -e

function log(){
    echo
    echo "##############################################"
    echo "#          $1                                "
    echo "##############################################"
    echo
}

echo "Setting up server on CentOS/RHE Linux Distro..."
echo
log "Installing Updates"
sudo yum update -y && sudo yum upgrade -y

log "Installing Packages"
sudo yum install $PACKAGES -y

log "Configuring user permissions"
sudo chown -R vagrant:vagrant /var/www/html

log "Setting up and Configuring Nginx"
sudo tee /etc/nginx/conf.d/my_site.conf > /dev/null <<EOF
server {
    listen $SVR_ADDRESS:80;
    server_name $SVR_ADDRESS;

    location / {
        root /var/www/html/;
        index index.html index.htm;
        try_files \$uri \$uri/ =404;
    }
}
EOF

log "Starting firewalld service"
sudo systemctl start firewalld
sudo systemctl enable firewalld

log "Adjusting firewall rules"
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

log "Starting Nginx service"
sudo systemctl start nginx
sudo systemctl enable nginx

echo "Setup Done!"