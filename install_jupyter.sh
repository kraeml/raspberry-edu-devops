#!/bin/bash
# script name:     install_jupyter.sh
# last modified:   2017/02/30
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

sudo cp jupyter.service /lib/systemd/system/
sudo chmod 644 /lib/systemd/system/jupyter.service
sudo systemctl daemon-reload
sudo systemctl enable jupyter.service
service jupyter start
