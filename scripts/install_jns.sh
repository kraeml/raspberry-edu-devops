#!/bin/bash
# script name:     install_jns.sh
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run without root"
   exit 1
fi

# run scripts
./install_jns_medium.sh
sudo ./install_stack.sh
