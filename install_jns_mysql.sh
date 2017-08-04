#!/bin/bash
# script name:     install_jns_mysql.sh
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

MYSQL_ROOT_PASSWORD=root
echo "Install software"

echo "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD" | sudo debconf-set-selections
sudo apt-get update
sudo apt install -y mysql-server


sudo sed -i 's/bind-address[[:space:]]*=[[:space:]]*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/my.cnf
sudo systemctl restart mysql.service
