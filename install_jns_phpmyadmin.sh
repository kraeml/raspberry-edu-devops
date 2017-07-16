#!/bin/bash
# script name:     install_jns_phpmyadmin.sh
# last modified:   2017/03/31
# sudo:            no

cd /tmp
version="4.7.2"
wget https://files.phpmyadmin.net/phpMyAdmin/${version}/phpMyAdmin-${version}-all-languages.tar.gz
tar xvf phpMyAdmin-${version}-all-languages.tar.gz
sudo mv phpMyAdmin-${version}-all-languages /var/www/html/phpMyAdmin
sudo chown -R www-data: /var/www/html/phpMyAdmin/
rm phpMyAdmin-${version}-all-languages.tar.gz
