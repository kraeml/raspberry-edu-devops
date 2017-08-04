#!/bin/bash
# script name:     install_python.sh
# last modified:   2017/03/30
# sudo:            yes
#
# see: http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#Python 3 version to install
version="3.6.2"
which python3
if [ "$?" -eq 0 ] && [ "${version}" = "$(python3 --version | cut -d\  -f 2)" ]
then
    exit
fi

# Packages Dependencies for building python3
#------------------------------------------------------
apt-get install -y build-essential libncursesw5-dev
apt-get install -y libgdbm-dev libc6-dev
apt-get install -y zlib1g-dev libsqlite3-dev tk-dev
apt-get install -y libssl-dev openssl
apt-get install -y libreadline-dev libbz2-dev
#------------------------------------------------------

wget "https://www.python.org/ftp/python/$version/Python-$version.tgz"
tar zxvf "Python-$version.tgz"
cd "Python-$version"
./configure
make
make install
pip3 install pip --upgrade

### install rest of the libraries, as well as freetrype
apt-get install libjpeg-dev libfreetype6 libfreetype6-dev

### re-install PIL
pip3 install pillow sense-hat rpi.gpio

# clean up
cd ..
rm -rf "./Python-$version"
rm "./Python-$version.tgz"

git clone https://github.com/RPi-Distro/RTIMULib.git
cd RTIMULib/Linux/python/
python3 setup.py build
python3 setup.py install
cd -
rm -rf RTIMULib

echo 'python=python3.6' | tee /home/pi/.npmrc | /root/.npmrc
chown pi:pi /home/pi/.npmrc
