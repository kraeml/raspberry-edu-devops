#!/bin/bash
# script name:     install_lxc.sh

# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

sudo apt-get install --yes --force-yes -t stretch lxc bridge-utils
