#!/bin/bash
# script name:     install_docker.sh
# sudo:            no

export DEBIAN_FRONTEND=noninteractive

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

#docker version to install
version="17"
which docker
if [ "$?" -eq 0 ] && [ "${version}" = "$(docker --version | cut -d\  -f 3)" ]
then
    exit
fi

curl -sSL https://get.docker.com | sudo sh
sudo usermod -aG docker pi
