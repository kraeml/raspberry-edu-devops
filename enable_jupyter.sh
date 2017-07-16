#!/bin/bash
# script name:     enable_jupyter.sh
# last modified:   2017/02/30
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

# Enable and start Jupyter as service
cp jupyter.service /lib/systemd/system/
chmod 644 /lib/systemd/system/jupyter.service
systemctl daemon-reload
systemctl enable jupyter.service
systemctl start jupyter.service
