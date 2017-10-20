#!/bin/bash -l
# script name:     inspec_edu.sh
# sudo:            no
node-red-admin login
LC_MESSAGES=C sudo bash -l -c 'inspec exec /home/pi/.raspberry-edu-devops/inspec-edu-devops'

cd /home/pi/.raspberry-edu-devops/capybara-edu-devops
sudo sed -i 's/jns:jns$/:/' /lib/systemd/system/cloud9.service
sudo systemctl daemon-reload
sudo systemctl restart cloud9.service
bundle exec cucumber
sudo sed -i 's/:$/jns:jns/' /lib/systemd/system/cloud9.service
sudo systemctl daemon-reload
sudo systemctl restart cloud9.service
cd -
