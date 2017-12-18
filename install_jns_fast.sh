#!/bin/bash
# script name:     install_jns.sh
# sudo:            no

if [ ! -e $HOME/.firstboot_basic ]; then
    touch $HOME/.firstboot_basic
    # Timestamp the logfile
    date

    if [ $(id -u) = 0 ]; then
       echo "to be run without sudo"
       exit 1
    fi

    # Change PWD to the binaries directory
    pushd $HOME/.raspberry-edu-devops
        # run scripts
        ./update-scripts.sh | tee -a /var/log/$USER/post-boot.log | logger -p local7.info -t update-scripts-post-boot
        sudo ./install_python.sh | tee -a /var/log/$USER/post-boot.log | logger -p local7.info -t python-post-boot
        ./install_ansible.sh | tee -a /var/log/$USER/post-boot.log | logger -p local7.info -t ansible-post-boot
        ./install_inspec.sh | tee -a /var/log/$USER/post-boot.log | logger -p local7.info -t inspec-post-boot
        date
    popd

    systemd-analyze | logger -t analyzer

    systemd-analyze critical-chain | logger -t analyzer

    (sleep 3660; systemd-analyze critical-chain --fuzz=1h | logger -t late-fast-analyzer) &
else
    echo "First boot base script still running"
fi
