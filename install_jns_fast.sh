#!/bin/bash
# script name:     install_jns.sh
# sudo:            no

# Timestamp the logfile
date

if [ $(id -u) = 0 ]; then
   echo "to be run without sudo"
   exit 1
fi

# Change PWD to the binaries directory
pushd $HOME/.raspberry-edu-devops
    # run scripts
    ./update-scripts.sh | tee -a ../post-boot.log | logger -p local7.info -t update-scripts-post-boot
    sudo ./install_python.sh | tee -a ../post-boot.log | logger -p local7.info -t python-post-boot
    sudo ./install_jupyter.sh | tee -a ../post-boot.log | logger -p local7.info -t jupyter-post-boot
    ./configure_jupyter.sh | tee -a ../post-boot.log | logger -p local7.info -t configure-jupyter-boot
    sudo ./enable_jupyter.sh | tee -a ../post-boot.log | logger -p local7.info -t jupyter-post-service
    date
popd

systemd-analyze | logger -t analyzer

systemd-analyze critical-chain | logger -t analyzer

(sleep 3660; systemd-analyze critical-chain --fuzz=1h | logger -t late-fast-analyzer) &
