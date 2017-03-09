#!/bin/bash
# script name:     install_jns.sh
# last modified:   2015/09/30
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run without root"
   exit 1
fi

# run scripts
sudo ./install_python.sh
sudo ./install_jupyter.sh
./configure_jupyter.sh
sudo ./install_tex.sh
sudo ./install_stack.sh
