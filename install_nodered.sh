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
sleep 5
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
sudo npm install -g pm2 socket.io sqlite3 mongoose mysql express
sudo npm install -g javascripting learnyounode how-to-npm scope-chains-closures stream-adventure how-to-markdown learnyouhtml
sudo npm install -g functional-javascript-workshop bytewiser expressworks bug-clinic async-you test-anything learnyoumongo torrential

# ToDo could in a seperate file
git clone git://git.drogon.net/wiringPi
wiringPi/
./build
cd -
rm -rf wiringPi
