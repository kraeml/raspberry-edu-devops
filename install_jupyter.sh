#!/bin/bash
# script name:     install_jupyter.sh
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

# Packages Dependencies for building Jupyter
#------------------------------------------------------
apt-get -y install libncurses5-dev python-dev pandoc
#------------------------------------------------------

# Install Jupyter
pip3 install jupyter
pip3 install readline
pip3 install ipyparallel

# Install additional kernels
pip3 install bash_kernel
python3 -m bash_kernel.install
# No nodejs
# npm install -g ijavascript
# ijsinstall
pip3 install ipython-sql

# Activate jupyter extensions
jupyter nbextension enable --py --sys-prefix widgetsnbextension

# Create raspberry-edu-devops link into notebooks
ln -s /home/pi/.raspberry-edu-devops/notebooks/ /home/pi/notebooks/raspberry-edu-devops
