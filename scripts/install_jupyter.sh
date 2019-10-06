#!/bin/bash
# script name:     install_jupyter.sh
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

export DEBIAN_FRONTEND=noninteractive
echo "Packages Dependencies for building Jupyter"
#------------------------------------------------------
apt-get -y install libncurses5-dev python-dev pandoc
#------------------------------------------------------

echo "Install Jupyter"
pip3 install jupyter
pip3 install readline
pip3 install ipyparallel

echo "Install additional kernels"
pip3 install bash_kernel
python3 -m bash_kernel.install
# No nodejs
# npm install -g ijavascript
echo "ijsinstall"
pip3 install ipython-sql

echo "Activate jupyter extensions"
jupyter nbextension enable --py --sys-prefix widgetsnbextension
