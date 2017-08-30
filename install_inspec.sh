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

# Install webserver tests with capybara and co.
gem install 'bundler'
cd capybara-edu-devops
bundle install
cd -

# Visit http://elementalselenium.com/tips/38-headless
sudo apt-get install -y xvfb firefox-esr

sudo apt-get install libfontconfig1 libfreetype6
curl -o /tmp/phantomjs_2.1.1_armhf.deb -sSL https://github.com/fg2it/phantomjs-on-raspberry/releases/download/v2.1.1-wheezy-jessie/phantomjs_2.1.1_armhf.deb
sudo dpkg -i /tmp/phantomjs_2.1.1_armhf.deb
curl -L https://github.com/mozilla/geckodriver/releases/download/v0.18.0/geckodriver-v0.18.0-arm7hf.tar.gz | sudo tar xz -C /usr/local/bin/

# Visit https://realpython.com/blog/python/headless-selenium-testing-with-python-and-phantomjs/
sudo pip3 install selenium pyvirtualdisplay
