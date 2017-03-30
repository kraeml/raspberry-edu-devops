#!/bin/bash
# script name:     install_jns_medium.sh
# last modified:   2017/03/30
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run without sudo"
   exit 1
fi

# run scripts
./install_jns_fast.sh
sudo ./install_tex.sh
sudo ./install_dependencies.sh
./install_nodered.sh
./install_cloud9.sh
