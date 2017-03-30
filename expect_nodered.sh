#!/usr/bin/expect -f
# script name:     expect_nodered.sh
# last modified:   2017/03/30
# sudo:            no

spawn /tmp/update-nodejs-and-nodered
expect "Are you really sure *"
send "y\r"
interact
