#!/bin/bash -l
# script name:     install_ansible.sh
# sudo:            no
set -x

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

echo "Install ansible via pip"
sudo apt-get install -y libffi-dev libssl-dev cowsay sshpass
sudo pip3 install ansible pywinrm

sudo mkdir -p /etc/ansible
sudo cp files/etc/ansible/hosts /etc/ansible/
set +x
