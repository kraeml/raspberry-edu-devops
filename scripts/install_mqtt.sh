#!/bin/bash
# script name:     install_mqtt.sh

# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

sudo apt-get install --yes mosquitto mosquitto-clients
