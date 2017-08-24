#!/bin/bash
# script name:     install_jns_php7.sh
# sudo:            no
# See: https://getgrav.org/blog/raspberrypi-nginx-php7-dev
# See: https://gist.github.com/Lewiscowles1986/ce14296e3f5222082dbaa088ca1954f7

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

# Pinning in install_dependencies.sh
# Remove old nginx-packages
sudo apt-get purge --yes nginx

sudo apt-get install --yes -t stretch php7.0 php7.0-curl php7.0-gd php7.0-fpm php7.0-cli php7.0-opcache php7.0-mbstring php7.0-xml php7.0-zip php7.0-mysql
sudo apt-get install -t stretch -y nginx-full
sudo apt-get autoremove --yes
sudo cp default /etc/nginx/sites-available/default
sudo update-rc.d nginx defaults
sudo update-rc.d php7.0-fpm defaults

# ToDo Write some inspec tests
sudo echo "<?php phpinfo();?>" | sudo tee /var/www/html/index.php
sudo chown -R www-data:www-data /var/www
sudo find /var/www/ -type d -exec sudo chmod 775 {} \;
# sudo find /var/www/ -type f -exec sudo chmod 644 {} \;

sudo usermod -aG www-data pi

sudo systemctl restart nginx
sudo systemctl restart php7.0-fpm

sudo pip3 install pillow sense-hat rpi.gpio
