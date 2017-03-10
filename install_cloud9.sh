#!/bin/bash
# script name:     install_jns.sh
# last modified:   2017/03/09
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi
sudo apt-get install tmux
git clone https://github.com/c9/core.git ~/cloud9
cd ~/cloud9
./scripts/install-sdk.sh
cd -

#node server.js -p 8181 -l 0.0.0.0 -w /home/pi -a :
