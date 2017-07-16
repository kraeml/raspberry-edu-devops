#!/bin/bash
# script name:     install_inspec.sh
# last modified:   2017/07/16
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

sudo apt-get update
sudo apt-get install --yes ruby ruby-dev gcc make
sudo gem update system
sudo gem cleanup
sudo gem install inspec
