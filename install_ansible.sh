#!/bin/bash
# script name:     install_ansible.sh
# last modified:   2017/07/16
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

#echo -e "deb http://httpredir.debian.org/debian jessie-backports main contrib non-free
#deb-src http://httpredir.debian.org/debian jessie-backports main contrib non-free" | sudo tee /etc/apt/sources.list.d/ansible.list
#sudo apt-get update
#sudo apt-get install --yes cowsay sshpass python-winrm
#sudo apt-get -t jessie-backports install --yes --force-yes ansible

sudo pip3 install ansible
