#!/bin/bash
# script name:     install_docker.sh
# last modified:   2017/03/30
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

curl -sSL https://get.docker.com | sudo sh
sudo usermod -aG docker pi
