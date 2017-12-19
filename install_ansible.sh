#!/bin/bash -l
# script name:     install_ansible.sh
# sudo:            no
set -x

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

echo "Install ansible via pip"
sudo apt-get install -y libffi-dev libssl-dev cowsay sshpass ieee-data

#ToDo kerberos dependencies
ANSIBLE="ansible pywinrm enum34 httplib2 idna ipaddress jinja2 crypto cryptography markupsafe netaddr paramiko pyasn1 six xmltodict"
sudo pip3 install $ANSIBLE  || (sudo apt-get install python3-pip && sudo pip3 install $ANSIBLE)

sudo mkdir -p /etc/ansible
sudo cp files/etc/ansible/hosts /etc/ansible/
set +x
