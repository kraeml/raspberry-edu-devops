#!/bin/bash
# script name:     install_dependencies.sh
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
# Needed for nodered
# Todo: Change for python3.6
apt-get install -y sense-hat rpi.gpio
apt-get install -y debian-keyring debian-archive-keyring
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
