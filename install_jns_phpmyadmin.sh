#!/bin/bash
# script name:     install_jns_phpmyadmin.sh
# sudo:            no

version="4.7.3"
wget --quiet https://files.phpmyadmin.net/phpMyAdmin/${version}/phpMyAdmin-${version}-all-languages.tar.gz
tar xvf phpMyAdmin-${version}-all-languages.tar.gz
sudo mv phpMyAdmin-${version}-all-languages /var/www/html/phpMyAdmin
sudo cp /home/$USER/.raspberry-edu-devops/config.inc.php /var/www/html/phpMyAdmin/
sudo chown -R www-data: /var/www/html/phpMyAdmin/
rm phpMyAdmin-${version}-all-languages.tar.gz
