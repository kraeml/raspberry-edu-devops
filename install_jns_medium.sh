#!/bin/bash
# script name:     install_jns_medium.sh
# last modified:   2017/03/30
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run without sudo"
   exit 1
fi
sudo chown -R pi: .
# Additional scripts to be executed on the first boot after install.
# This makes the `raspbian-ua-netinst` installer more uniform and easier
# to maintain regardless of the use.
if [ ! -e $HOME/.firstboot ]; then
  echo -n "First boot detected on "
  export HOME=/home/pi
  export USER=pi
  date
  touch $HOME/.firstboot
  # run scripts
  ./install_jns_fast.sh
  sudo ./install_tex.sh
  sudo ./install_dependencies.sh
  ./install_nodered.sh
  ./install_cloud9.sh
  ./install_docker.sh
  ./install_jns_php7.sh
  ./install_jns_mysql.sh
  ./install_jns_phpmyadmin.sh

  sudo shutdown -r +1 "First boot installation completed. Please log off now."
  echo -n "First boot installation completed on "
  date
fi

