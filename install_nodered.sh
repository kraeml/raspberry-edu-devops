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
  # ToDo: Change path /home/pi/bin into variables
  # curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > /home/pi/bin/update-nodejs-and-nodered
  # cp update-nodejs-and-nodered /home/pi/bin/update-nodejs-and-nodered
  # chmod u+x /home/pi/bin/update-nodejs-and-nodered
  #./expect_nodered.sh
  ./update-nodejs-and-nodered
  sudo systemctl daemon-reload
  sudo systemctl enable nodered.service
  sudo systemctl restart nodered.service
fi

# Install additional jupyter kernels after installed nodejs
sudo npm install -g ijavascript
sudo ijsinstall --install=global
sudo systemctl restart jupyter.service
