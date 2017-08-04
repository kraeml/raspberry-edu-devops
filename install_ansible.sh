#!/bin/bash -l
# script name:     install_ansible.sh
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

sudo apt-get install -y libffi-dev
sudo pip3 install ansible
