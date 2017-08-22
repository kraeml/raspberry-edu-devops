#!/bin/bash -l

# --------------------------------------------------------------------------------------------
# Installs Ruby 2.4 using rbenv/ruby-build on the Raspberry Pi (Raspbian)
#
# Run from the web:
#   bash <(curl -s https://gist.githubusercontent.com/blacktm/8302741/raw/install_ruby_rpi.sh)
# --------------------------------------------------------------------------------------------

export DEBIAN_FRONTEND=noninteractive
# Time the install process
START_TIME=$SECONDS

# Check out rbenv into ~/.rbenv
sudo git clone https://github.com/rbenv/rbenv.git /usr/local/src/rbenv
cd /usr/local/src/rbenv
sudo src/configure && sudo make -C src
sudo cp libexec/rbenv /usr/local/bin/
export RBENV_ROOT=/usr/local/rbenv
sudo mkdir -p /usr/local/rbenv/plugins
sudo chmod 777 /usr/local/rbenv

export PATH=/usr/local/src/rbenv/libexec:$PATH
# Add ~/.rbenv/bin to $PATH, enable shims and autocompletion
read -d '' String <<"EOF"
# rbenv
export RBENV_ROOT=/usr/local/rbenv
export PATH=/usr/local/src/rbenv/libexec:$PATH

eval "$(rbenv init -)"
EOF

# Save to /etc/profile.d/rbenv.sh
echo -e "\n${String}" | sudo tee /etc/profile.d/rbenv.sh

# Enable rbenv for current shell
eval "${String}"

# Install ruby-build as an rbenv plugin, adds `rbenv install` command
sudo git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# Install dependencies
#  See: https://github.com/rbenv/ruby-build/wiki#suggested-build-environment
sudo apt update
sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

# Install Ruby 2.4, don't generate RDoc to save lots of time
CONFIGURE_OPTS="--disable-install-doc --enable-shared" /usr/local/bin/rbenv install 2.4.1 --verbose

# Set Ruby 2.4 as the global default
/usr/local/bin/rbenv global 2.4.1

# Don't install docs for gems (saves lots of time)
echo "gem: --no-document" > ~/.gemrc

# Print the time elapsed
ELAPSED_TIME=$(($SECONDS - $START_TIME))
echo -e "\nFinished in $(($ELAPSED_TIME/60/60)) hr, $(($ELAPSED_TIME/60%60)) min, and $(($ELAPSED_TIME%60)) sec\n"

sudo rm -rf /tmp/ruby-build*
