#!/bin/bash
# script name:     install_jns.sh
# last modified:   2017/03/09
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > /tmp/update-nodejs-and-nodered
chmod u+x /tmp/update-nodejs-and-nodered
./expect_nodered.sh
rm /tmp/update-nodejs-and-nodered
sudo systemctl enable nodered.service
