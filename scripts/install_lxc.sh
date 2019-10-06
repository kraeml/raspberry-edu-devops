#!/bin/bash
# script name:     install_lxc.sh

# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

export DEBIAN_FRONTEND=noninteractive

sudo apt-get install --yes --force-yes lxc bridge-utils debootstrap
#apt-get install -y lxc
#mkdir -p /var/lxc/guests/test
#debootstrap jessie /var/lxc/guests/test/fs/ http://archive.raspbian.org/raspbian
