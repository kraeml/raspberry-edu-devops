#!/bin/bash
# script name:     install_python.sh
# last modified:   2016/12/29
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#------------------------------------------------------
apt-get install -y python3 python3-dev python3-pip 
#------------------------------------------------------

pip3 install -U pip
