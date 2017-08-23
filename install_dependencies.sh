#!/bin/bash -x
# script name:     install_dependencies.sh
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html
# After create python3 on rpi

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

## Apt pinning see: https://wiki.ubuntuusers.de/Apt-Pinning/
echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" > /etc/apt/sources.list.d/stretch.list
echo -e "Package: *\nPin: release n=jessie\nPin-Priority: 600" > /etc/apt/preferences.d/jessie.pref
echo "APT::Default-Release \"jessie\";" > /etc/apt/apt.conf.d/99-default-release
apt-get update
apt-get install -y nmap curl sudo expect
# Needed for nodered
apt-get install -y sense-hat rpi.gpio
apt-get install -y debian-keyring debian-archive-keyring
apt-get update
apt-get upgrade -y
sleep 20
apt-get install -y dphys-swapfile lsb-core
pip3 install pillow sense-hat rpi.gpio
