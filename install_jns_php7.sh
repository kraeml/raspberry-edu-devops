#!/bin/bash
# script name:     install_jns_php7.sh
# last modified:   2017/03/31
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

sudo echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" | sudo tee /etc/apt/sources.list.d/stretch.list
sudo apt-get update
sudo echo -e "Package: *\nPin: release n=jessie\nPin-Priority: 600" | sudo tee /etc/apt/preferences.d/jessie.pref
sudo apt-get install --yes -t stretch php7.0 php7.0-curl php7.0-gd php7.0-fpm php7.0-cli php7.0-opcache php7.0-mbstring php7.0-xml php7.0-zip php7-mysql nginx
# Remove old nginx-packages
sudo apt-get autoremove --yes
sudo cp default /etc/nginx/sites-available/default
sudo service nginx restart
sudo service php7.0-fpm restart
