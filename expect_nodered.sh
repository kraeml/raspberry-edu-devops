#!/usr/bin/expect -f
# script name:     expect_nodered.sh
# last modified:   2017/03/30
# sudo:            no

set timeout -1
match_max 100000
spawn /home/pi/bin/update-nodejs-and-nodered
expect "Are you really sure *"
send -- "y\r"
#interact
expect eof
#exit
