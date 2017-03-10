#!/usr/bin/expect -f
# script name:     install_jns.sh
# last modified:   2017/03/09
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

spawn bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)
expect "Are you really sure you want to do this ? (y/N) ? "
send "y\n"
sudo systemctl enable nodered.service

##!/usr/bin/expect -f
#spawn ssh-add /home/vagrant/.ssh/id_rsa
#expect "Enter passphrase for /home/vagrant/.ssh/id_rsa:"
#send "geheim\n";
#interact
