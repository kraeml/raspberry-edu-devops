#!/bin/bash
# script name:     install_jupyter.sh
# last modified:   2017/02/06
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

apt-get install -y pandoc

pip3 install jupyter
pip3 install bash_kernel

#------------------------------------------------------
apt-get -y install libncurses5-dev
apt-get -y install python-dev
#------------------------------------------------------

pip3 install readline
pip3 install ipyparallel

python3 -m bash_kernel.install

cp jupyter.service /etc/systemd/system/jupyter.service
service jupyter start
