#!/bin/bash -l
# script name:     install_nodered.sh
# sudo:            no
set -x
export DEBIAN_FRONTEND=noninteractive
if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

if [[ -f /usr/bin/node-red ]]; then
  echo "Nodered already installed"
else
  # chmod u+x /home/$USER/bin/update-nodejs-and-nodered
  #./expect_nodered.sh
  ./update-nodejs-and-nodered
  sudo systemctl daemon-reload
  sudo systemctl enable nodered.service
  sudo systemctl restart nodered.service
fi

# Update npm and install npm-check
# May not work with etherpad-lite
# sudo npm install -g npm@latest
sudo npm install -g npm-check
sudo npm config --global set unsafe-perm=true

# Install node-red-admin
sudo npm install -g node-red-admin

# Install node-red addons
cd /home/$USER/.node-red
npm i node-red-dashboard
npm install node-red-contrib-bigtimer
npm install node-red-node-mongodb
npm install node-red-node-mysql
# Install for blinkt
npm install node-red-contrib-looptimer
mkdir nodes
cd nodes
git clone http://github.com/pimoroni/node-red-nodes pimoroni-nodes
cd -

sudo systemctl restart nodered.service
# Sleep 20 seconds to nodered come up
sleep 20
# Disable unused nodes
node-red-admin login
node-red-admin disable node-red/node-flotilla
node-red-admin disable node-red-node-ledborg/ledborg
node-red-admin disable node-red/rpi-explorerhat
node-red-admin disable node-red/rpi-unicorn

sudo systemctl restart nodered.service

# Install additional jupyter kernels after installed nodejs
sudo npm install -g ijavascript
sudo ijsinstall --install=global
sudo systemctl restart jupyter.service

# Additional packages for web-dev learning
sudo apt-get install --yes sqlite3
sudo npm install -g pm2
sudo npm install -g socket.io
sudo npm install -g sqlite3
sudo npm install -g mongoose
sudo npm install -g mysql
sudo npm install -g express
sudo npm install -g javascripting
sudo npm install -g how-to-npm
sudo npm install -g scope-chains-closures
sudo npm install -g stream-adventure
sudo npm install -g how-to-markdown
sudo npm install -g learnyouhtml
sudo npm install -g learnyounode
sudo npm install -g functional-javascript-workshop
sudo npm install -g bytewiser
sudo npm install -g expressworks
sudo npm install -g bug-clinic
sudo npm install -g async-you
sudo npm install -g test-anything
sudo npm install -g learnyoumongo
sudo npm install -g torrential
sudo npm install -g html-validator-cli

set +x
