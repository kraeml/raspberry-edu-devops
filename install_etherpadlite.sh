#!/bin/bash
# script name:     install_etherpadlite.sh

# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

sudo apt-get install -y libreoffice abiword
wget https://github.com/ether/etherpad-lite/zipball/master -O etherpad-lite.zip
unzip etherpad-lite.zip
rm etherpad-lite.zip
sudo mkdir -p /opt/etherpad
sudo mv ether-etherpad-lite-*/* /opt/etherpad/
sudo adduser --system --home /opt/etherpad --group etherpad
sudo chown -R etherpad:etherpad /opt/etherpad
sudo -H -u etherpad /opt/etherpad/bin/installDeps.sh

# ToDo etherpad-lite not running yet
