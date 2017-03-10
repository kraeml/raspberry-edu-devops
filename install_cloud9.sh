#!/bin/bash
# script name:     install_jns.sh
# last modified:   2017/03/09
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi
sudo apt-get install -y tmux
git clone https://github.com/c9/core.git ${HOME}/cloud9
cd ${HOME}/cloud9
./scripts/install-sdk.sh
cd -
sudo cp cloud9.service /etc/systemd/system/
sudo chmod 755 /etc/systemd/system/cloud9.service
sudo systemctl daemon-reload
sudo service cloud9 start

#node server.js -p 8181 -l 0.0.0.0 -w /home/pi -a :
