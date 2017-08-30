#!/bin/bash -l
# script name:     inspec_edu.sh
# sudo:            no
node-red-admin login
LC_MESSAGES=C sudo bash -l -c 'inspec exec /home/pi/.raspberry-edu-devops/inspec-edu-devops'

cd /home/pi/.raspberry-edu-devops/capybara-edu-devops
bundle exec cucumber 
cd -
