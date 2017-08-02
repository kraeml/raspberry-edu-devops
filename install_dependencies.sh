#!/bin/bash
# script name:     install_dependencies.sh
# last modified:   2017/08/02
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html
# After create python3 on rpi

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

apt-get update
apt-get install -y nmap curl sudo expect
apt-get install -y debian-keyring debian-archive-keyring
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010

### install rest of the libraries, as well as freetrype and zlib
apt-get install libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev

### re-install PIL
pip3 install pillow sense-hat rpi.gpio
