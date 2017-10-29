#!/bin/bash

# script name:     install_jns.sh
# sudo:            no

# Additional scripts to be executed on the first boot after install.
# This makes the `raspbian-ua-netinst` installer more uniform and easier
# to maintain regardless of the use.
if [ ! -e $HOME/.firstboot ]; then
    touch $HOME/.firstboot
    sudo rm /etc/cron.d/raspboot
    # Timestamp the logfile
    date

    if [ $(id -u) = 0 ]; then
       echo "to be run without sudo"
       exit 1
    fi
    sudo chown -R pi: .
    export DEBIAN_FRONTEND=noninteractive
    # Change PWD to the binaries directory
    pushd $HOME/.raspberry-edu-devops
        echo -n "First boot detected on "
        date
        # run scripts
        ./install_jns_fast.sh
        ansible-galaxy install -r requirements.yml| tee -a /var/log/pi/post-boot.log | logger -p local7.info -t ansible-galaxy-install-post-boot
        ansible-playbook raspberry.yml | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t ansible-playbook-post-boot
        # sudo ./install_jupyter.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t jupyter-post-boot
        # ./configure_jupyter.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t configure-jupyter-boot
        # sudo ./enable_jupyter.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t jupyter-post-service
        # sudo ./install_dependencies.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t dependencies-post-boot
        # sudo ./install_tex.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t tex-post-boot
        # ./install_nodered.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t nodered-post-boot
        # ./install_cloud9.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t cloud9-post-boot
        # ./install_docker.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t docker-post-boot
        # ./install_jns_php7.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t php7-post-boot
        # ./install_jns_mysql.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t mysql-post-boot
        # ./install_jns_phpmyadmin.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t phpmyadmin-post-boot
        # ./install_mongodb.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t mongodb-post-boot
        # ToDo ./install_lxc.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t lxc-post-boot
        # ./install_mqtt.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t mqtt-post-boot
        # ./install_etherpadlite.sh | tee -a /var/log/pi/post-boot.log | logger -p local7.info -t etherpadlite-post-boot
        sudo apt-get update
        sudo apt-get dist-upgrade --yes --force-yes
        sudo shutdown -r +1 "First boot installation completed. Please log off now."
        echo -n "First boot installation completed on "
        date
  popd
  systemd-analyze | logger -t analyzer
  systemd-analyze critical-chain | logger -t analyzer
  (sleep 3660; systemd-analyze critical-chain --fuzz=1h | logger -t late-medium-analyzer) &
else
    echo "First boot script still running"
fi
