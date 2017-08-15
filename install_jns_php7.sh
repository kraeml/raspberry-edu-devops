#!/bin/bash
# script name:     install_jns_php7.sh
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

#php version to install
version="7"
which php
if [ "$?" -eq 0 ] && [ "${version}" = "$(php --version | grep "^PHP" | cut -d\  -f 2) | cut -d \. -f 1" ]
then
    exit
fi

sudo apt-get install --yes -t stretch php7.0 php7.0-curl php7.0-gd php7.0-fpm php7.0-cli php7.0-opcache php7.0-mbstring php7.0-xml php7.0-zip php7.0-mysql nginx
# Remove old nginx-packages
sudo apt-get autoremove --yes
sudo cp default /etc/nginx/sites-available/default
sudo service nginx restart
sudo service php7.0-fpm restart
