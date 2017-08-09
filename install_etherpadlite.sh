#!/bin/bash
# script name:     install_etherpadlite.sh

# sudo:            no
# Found on Rasperry Pi Geek 2017/10

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
cd /opt/etherpad
sudo -H -u etherpad /usr/bin/npm install ep_activepads ep_adminpads ep_copy_paste_images ep_cursortrace ep_draw
sudo -H -u etherpad /usr/bin/npm install ep_font_family ep_font_size ep_horizontal_line ep_latexexport
sudo -H -u etherpad /usr/bin/npm install ep_markdown ep_markdownify ep_padlist ep_print ep_printer
sudo -H -u etherpad /usr/bin/npm install ep_search ep_spellcheck ep_tables ep_tokbox ep_rtc ep_xmlexport
cd -
sudo chown -R etherpad:etherpad /opt/etherpad

# ToDo etherpad-lite not running yet
