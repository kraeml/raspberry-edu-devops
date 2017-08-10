#!/bin/bash
# script name:     install_etherpadlite.sh

# sudo:            no
# Found on Rasperry Pi Geek 2017/10

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

# Dependencies for etherpad-lite
sudo apt-get install -y libreoffice abiword
# Dependencies for etherdraw
sudo apt-get install -y libcairo2-dev libjpeg-dev libpango1.0-dev libgif-dev build-essential g++

#wget https://github.com/ether/etherpad-lite/zipball/master -O etherpad-lite.zip
#unzip etherpad-lite.zip
#rm etherpad-lite.zip
sudo git clone git://github.com/ether/etherpad-lite.git /opt/etherpad
# sudo mkdir -p /opt/etherpad
# sudo mv ether-etherpad-lite-*/* /opt/etherpad/
sudo adduser --system --home /opt/etherpad --group etherpad
sudo cp ./settings.json /opt/etherpad
sudo chown -R etherpad:etherpad /opt/etherpad
sudo -H -u etherpad /opt/etherpad/bin/installDeps.sh
cd /opt/etherpad
sudo -H -u etherpad /usr/bin/npm install ep_activepads ep_adminpads ep_copy_paste_images ep_cursortrace ep_draw
sudo -H -u etherpad /usr/bin/npm install ep_font_family ep_font_size ep_horizontal_line ep_latexexport
sudo -H -u etherpad /usr/bin/npm install ep_markdown ep_markdownify ep_padlist ep_print ep_printer
sudo -H -u etherpad /usr/bin/npm install ep_search ep_spellcheck ep_tables ep_xmlexport
cd -
sudo chown -R etherpad:etherpad /opt/etherpad
# ToDo etherpad-lite not running yet

sudo cp ./etherpad-lite.service /etc/systemd/system/
sudo systemctl enable etherpad-lite
sudo systemctl start etherpad-lite

sudo git clone git://github.com/JohnMcLear/draw.git /opt/etherdraw
sudo adduser --system --home /opt/etherdraw --group etherdraw
# sudo cp ./settings.json /opt/etherdraw
sudo chown -R etherdraw:etherdraw /opt/etherdraw
sudo -H -u etherdraw /opt/etherdraw/bin/installDeps.sh

sudo mkdir /var/log/etherdraw/
sudo chmod 777 /var/log/etherdraw/
sudo cp ./etherdraw /etc/init.d/
sudo chmod +x /etc/init.d/etherdraw
sudo update-rc.d etherdraw defaults
sudo systemctl start etherdraw.service
