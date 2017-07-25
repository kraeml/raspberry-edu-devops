#!/bin/bash
# script name:     install_dependencies.sh
# last modified:   2017/03/30
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip3 install rpi.gpio
apt-get update
apt-get install -y nmap curl sudo sense-hat expect python-rpi.gpio debian-keyring debian-archive-keyring
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
