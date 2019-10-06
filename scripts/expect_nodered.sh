#!/usr/bin/expect -f
# script name:     expect_nodered.sh
# sudo:            no

set timeout -1
match_max 100000
spawn ./update-nodejs-and-nodered
expect "Are you really sure *"
send -- "y\r"
#interact
expect eof
#exit
