#!/bin/bash
# script name:     install_jns.sh
# last modified:   2017/03/09
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run without sudo"
   exit 1
fi

# run scripts
sudo ./install_python.sh
sudo ./install_jupyter.sh
./configure_jupyter.sh
#./install_tex.sh
#./install_stack.sh
