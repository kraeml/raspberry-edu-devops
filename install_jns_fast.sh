#!/bin/bash
# script name:     install_jns.sh
# last modified:   2015/09/30
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

# run scripts
sudo ./install_python.sh
sudo ./install_jupyter.sh
./configure_jupyter.sh
#./install_tex.sh
#./install_stack.sh
