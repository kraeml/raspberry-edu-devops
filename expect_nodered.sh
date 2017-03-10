#!/usr/bin/expect -f
# script name:     install_jns.sh
# last modified:   2017/03/09
# sudo:            no

spawn /tmp/update-nodejs-and-nodered
expect "Are you really sure *"
send "y\r"
interact
