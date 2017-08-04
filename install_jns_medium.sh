#!/bin/bash -l

# script name:     install_jns.sh

# sudo:            no

# Timestamp the logfile
date

if [ $(id -u) = 0 ]; then
   echo "to be run without sudo"
   exit 1
fi
sudo chown -R pi: .
# Additional scripts to be executed on the first boot after install.
# This makes the `raspbian-ua-netinst` installer more uniform and easier
# to maintain regardless of the use.
if [ ! -e $HOME/.firstboot ]; then
    # Change PWD to the binaries directory
    pushd $HOME/.raspberry-edu-devops
        echo -n "First boot detected on "
        date
        touch $HOME/.firstboot
        # run scripts
        ./install_jns_fast.sh
        sudo ./install_dependencies.sh | tee -a ../post-boot.log | logger -p local7.info -t dependencies-post-boot
        ./install_ansible.sh | tee -a ../post-boot.log | logger -p local7.info -t ansible-post-boot
        ./install_inspec.sh | tee -a ../post-boot.log | logger -p local7.info -t inspec-post-boot
        sudo ./install_tex.sh | tee -a ../post-boot.log | logger -p local7.info -t tex-post-boot
        ./install_cloud9.sh | tee -a ../post-boot.log | logger -p local7.info -t cloud9-post-boot
        ./install_nodered.sh | tee -a ../post-boot.log | logger -p local7.info -t nodered-post-boot
        ./install_docker.sh | tee -a ../post-boot.log | logger -p local7.info -t docker-post-boot
        ./install_jns_php7.sh | tee -a ../post-boot.log | logger -p local7.info -t php7-post-boot
        ./install_jns_mysql.sh | tee -a ../post-boot.log | logger -p local7.info -t mysql-post-boot
        ./install_jns_phpmyadmin.sh | tee -a ../post-boot.log | logger -p local7.info -t phpmyadmin-post-boot
        sudo apt-get update
        sudo apt-get upgrade --yes
        sudo rm /etc/cron.d/raspboot
        sudo shutdown -r +1 "First boot installation completed. Please log off now."
        echo -n "First boot installation completed on "
        date
  popd
  systemd-analyze | logger -t analyzer
  systemd-analyze critical-chain | logger -t analyzer
  (sleep 3660; systemd-analyze critical-chain --fuzz=1h | logger -t late-medium-analyzer) &
fi
