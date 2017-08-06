#!/bin/bash -l
# script name:     install_nodered.sh
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

if [[ -f /usr/bin/node-red ]]; then
  echo "Nodered already installed"
else
  # chmod u+x /home/pi/bin/update-nodejs-and-nodered
  #./expect_nodered.sh
  ./update-nodejs-and-nodered
  sudo systemctl daemon-reload
  sudo systemctl enable nodered.service
  sudo systemctl restart nodered.service
fi

# Install node-red-admin
sudo npm install -g node-red-admin

# Install node-red addons
cd /home/pi/.node-red
npm i node-red-dashboard

sudo systemctl restart nodered.service

# Install additional jupyter kernels after installed nodejs
sudo npm install -g ijavascript
sudo ijsinstall --install=global
sudo systemctl restart jupyter.service
