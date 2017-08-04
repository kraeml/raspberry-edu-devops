#!/bin/bash
# script name:     install_cloud9.sh

# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi
sudo apt-get install -y tmux
if [[ -d $HOME/cloud9 ]]; then
  echo "Cloud9 already installed"
else
  git clone https://github.com/c9/core.git ${HOME}/cloud9
  cd ${HOME}/cloud9
  ./scripts/install-sdk.sh
  cd -
  sudo cp cloud9.service /lib/systemd/system/
  sudo chmod 644 /lib/systemd/system/cloud9.service
  sudo systemctl daemon-reload
  sudo systemctl enable cloud9.service
  sudo systemctl start cloud9.service
fi

# Manually run with
# node server.js -p 8181 -l 0.0.0.0 -w /home/pi -a :
