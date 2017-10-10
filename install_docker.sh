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
# apt-get remove --yes docker docker-engine docker.io
echo "deb [arch=armhf] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt update && sudo apt install --yes docker-ce
sudo usermod -aG docker pi
