#!/bin/bash
# script name:     install_dependencies.sh
# last modified:   2017/03/09
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip3 install rpi.gpio
apt-get update
apt-get install -y curl sudo sense-hat
