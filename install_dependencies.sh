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
echo "deb http://mirrordirector.raspbian.org/raspbian/ stretch main contrib non-free rpi" > /etc/apt/sources.list.d/stretch.list
echo -e "Package: *\nPin: release n=jessie\nPin-Priority: 600" > /etc/apt/preferences.d/jessie.pref
apt-get update
apt-get --yes upgrade
apt-get install -y nmap curl sudo expect
# Needed for nodered
# Todo: Change for python3.6
apt-get install -y sense-hat rpi.gpio
apt-get install -y debian-keyring debian-archive-keyring
apt-get install -y dphys-swapfile lsb-core
#apt-get install -y lxc
#mkdir -p /var/lxc/guests/test
#debootstrap jessie /var/lxc/guests/test/fs/ http://archive.raspbian.org/raspbian
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7638D0442B90D010
