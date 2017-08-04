#!/bin/bash -l
# script name:     install_inspec.sh
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

sudo apt-get update
# sudo apt-get install --yes ruby ruby-dev gcc make
# wget https://gist.githubusercontent.com/blacktm/8302741/raw/b498c27c03e2b7dcf79ca00183b6ccdf361b7001/install_ruby_rpi.sh
# chmod u+x install_ruby_rpi.sh
#sed -i 's/read -p "  Continue? (y\/n) " ans/ans="y"/g' install_ruby_rpi.sh
./install_ruby_rpi.sh
source /etc/profile.d/rbenv.sh
# rbenv
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
gem update system
gem cleanup
gem install inspec
