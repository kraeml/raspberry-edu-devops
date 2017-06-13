#!/bin/bash
# script name:     install_nodered.sh
# last modified:   2017/03/30
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

if [[ -f /usr/bin/node-red ]]; then
  echo "Nodered already installed"
else
  curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > /tmp/update-nodejs-and-nodered
  chmod u+x /tmp/update-nodejs-and-nodered
  ./expect_nodered.sh
  #sudo apt-get update && sudo apt-get install python-rpi.gpio
  #rm /tmp/update-nodejs-and-nodered
  sleep 1
  sudo systemctl enable nodered.service
  sleep 1
  sudo service nodered start
fi
