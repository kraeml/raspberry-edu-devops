#!/bin/bash -l
# script name:     inspec_edu.sh
# sudo:            no
node-red-admin login
sudo bash -l -c 'inspec exec /home/pi/.raspberry-edu-devops/inspec-edu-devops'
