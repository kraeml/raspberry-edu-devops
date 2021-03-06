#!/bin/bash -l
# script name:     install_python.sh
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html
set -x

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#Python 3 version to install
#version="3.6.3"
#which python3
#if [ "$?" -eq 0 ] && [ "${version}" = "$(python3 --version | cut -d\  -f 2)" ]
#then
#    exit
#fi
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
# Packages Dependencies for building python3
#------------------------------------------------------
apt-get install --yes build-essential libncursesw5-dev
apt-get install --yes libgdbm-dev libc6-dev
apt-get install --yes zlib1g-dev libsqlite3-dev tk-dev
apt-get install --yes libssl-dev openssl
apt-get install --yes libreadline-dev libbz2-dev
### install rest of the libraries, as well as freetrype
apt-get install --yes libcairo2-dev libjpeg-dev libpango1.0-dev
apt-get install --yes libgif-dev build-essential
apt-get install --yes libjpeg62-turbo libjpeg62-turbo-dev liblcms1-dev liblcms1
apt-get install --yes zlib1g libjpeg8 libjpeg-dev libfreetype6 libfreetype6-dev
apt-get install --yes libxslt1.1 libgirepository1.0-dev python3-cairo-dev
#------------------------------------------------------
# Needed for python-numpy
apt-get install --yes libatlas-base-dev
#wget --quiet "https://www.python.org/ftp/python/$version/Python-$version.tgz"
#tar zxvf "Python-$version.tgz"
#cd "Python-$version"
#./configure
#make
#make install
pip3 install --ignore-installed pip || \
    apt-get install --yes python3-pip && pip3 install --ignore-installed pip
#pip3 install pip --upgrade
pip3 install -U virtualenv

### install PIL
pip3 install pillow sense-hat rpi.gpio
pip3 install blinkt requests psutil paho-mqtt tweepy

git clone https://github.com/pimoroni/blinkt.git /home/$USER_CALL/blinkt
chown -R $USER_CALL: /home/$USER_CALL/blinkt

# clean up
#cd ..
#rm -rf "./Python-$version"
#rm "./Python-$version.tgz"

git clone https://github.com/RPi-Distro/RTIMULib.git
cd RTIMULib/Linux/python/
python3 setup.py build
python3 setup.py install
cd -
rm -rf RTIMULib

# pip3 list --outdated --format=legacy | cut -d' ' -f1 | xargs pip3 install --upgrade
pip3 list --outdated --format=columns | cut -d' ' -f1 | tail +3 | xargs pip3 install --upgrade
set +x
