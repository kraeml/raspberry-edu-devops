# Jupyter Notebook, Cloud9 and NodeRed Server on Raspberry Pi 2 and 3

Forked from: [kleinee/jns](https://github.com/kleinee/jns)

May could work on Pi B.

ToDo: Docker installer

## Intro

Sliderules are a thing of the past, decent calculators are hard to get by these days and spreadsheets are somewhat cumbersome, at times outright dangerous or just not the right tool for many tasks. Project Jupyter not only revolutionizes data-heavy research in all domains - it also boosts personal productivity for problems on a much smaller scale.

This repository documents my efforts to set up and configure a Jupyter Notebook Server on a Raspberry Pi 2 or 3 (Pi B+ should work) complete with Python 3.6.1, fully functioning nbconvert and a basic scientific stack with version 4.0 or later of all components making up the brilliant Jupyter interactive computing environment.

## Requirements

- a Raspberry Pi 2 or 3 complete with 5V micro-usb power-supply
- a blank 16 GB micro SD card
- alternative 1GB micro SD card with USB-Boot.
- an ethernet cable to connect the Pi to your network in case you are not using wifi
- an internet connection
- a computer to carry out the installation connected to the same network as the Pi
- a fair amount of time - user feedback suggests that a full installation takes in the order of 6 hours...

## Preparing the Raspbian Jessie Lite Image or Ua-Netinstall

Download the official Raspbian Jessie Lite image and transfer it to your SD card. Boot the Pi with the fresh image, log in (root password is raspbian and default user is pi) to set up timezone and locales and expand the filesystem using the raspi-config utility:

```bash
sudo raspi-config
```

Ensure that your installation is up to date and then use apt-get to install pandoc and git:

```bash
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y pandoc
sudo apt-get install -y git
sudo apt-get install -y screen
```

## Clone the GitHub Repository

Reboot and log in as user pi via ssh. From the terminal run:

```bash
cd
git clone https://github.com/kraeml/jns.git
cd jns
```

## Server Installation

```bash
./install_jns_medium.sh
```

This will create a directory notebooks in the home directory of user pi, clone this repository to get the installtion scripts, make sure the scripts are executable and then run install_jns_medium.sh which does the following:

- install Python
- install Jupyter
- (pre)-configure the notebook server
- install TeX
- install node-red
- install cloud9

## ToDo not Testet in this fork

./install_jns.sh

- install scientific stack (not in medium)

The script is nothing spectacular - just convenience to save us some typing. The next section briefly describes the individual steps.

**TODO** Changes made from kraeml

```bash
#!/bin/bash
# script name:     install_jns_medium.sh
# last modified:   2017/03/12
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run without sudo"
   exit 1
fi

# run scripts
./install_jns_fast.sh
sudo ./install_tex.sh
sudo ./install_dependencies.sh
./install_nodered.sh
./install_cloud9.sh
```

```bash
#!/bin/bash
# script name:     install_jns_fast.sh
# last modified:   2017/03/12
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run without sudo"
   exit 1
fi

# run scripts
sudo ./install_python.sh
sudo ./install_jupyter.sh
./configure_jupyter.sh
```

If everything goes to plan you end up with a fully functional Jupyter Notebook, Cloud9 and NodeRed server!!! The servers should start on startup.

Other weise run

```bash
sudo service jupyter restart
sudo service cloud9 restart
sudo service nodered restart
```

You should now be able to access the system from any browser on your network via the IP address of the Raspberry Pi on port 8888\. The **notebook server password*** set during installation is **_jns_**. This can be changed if requirerd.

## Step by Step Installation + Configuration

If you prefer a setp by step installation, execute the respective shell scripts in the order given below:

- To install Python 3.6.1 run `install_python.sh`
- To install TeX run `install_tex.sh`
- To install Jupyter run `install_jupyter.sh`
- To configure Jupyter run `configure_jupyter.sh`
- To install scientific stack run `install_stack.sh`
- To install Cloud9-IDE run `install_cloud9.sh`
- To install NodeRed run `install_nodered.sh`

### Python 3.6.1 Installation

Instructions for building Python from source can be found [here](http://sowingseasons.com/blog/building-python-3-4-on-raspberry-pi-2.html). I adjusted them to suit installation of Python 3.6.1 and turned the instructions into a script:

```bash
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
version="3.6.1"

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

# clean up

cd ..

rm -rf "./Python-$version"
rm "./Python-$version.tgz"
```

### TeX Installation

We need TeX for notebook conversion to PDF format with nbconvert / pandoc.

```bash
#!/bin/bash
# script name:     install_tex.sh
# last modified:   2017/03/05
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

#------------------------------------------------------
apt-get install -y texlive
apt-get install -y texlive-latex-extra
apt-get install -y dvipng
apt-get install -y texlive-xetex
#------------------------------------------------------
```

### Jupyter Installation

The developers made this step amazingly simple. The only minor issue that I came across was that IPython complained about missing readline upon first start. We adress this here by installing readline. We also install ipyparallel as it is not installed by default.

**_NOTE_** readline might no longer be required. Will adjust once I had time to test.

```bash
#!/bin/bash
# script name:     install_jupyter.sh
# last modified:   2017/02/30
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

apt-get install -y pandoc

pip3 install jupyter
pip3 install bash_kernel

#------------------------------------------------------
apt-get -y install libncurses5-dev
apt-get -y install python-dev
#------------------------------------------------------

pip3 install readline
pip3 install ipyparallel

python3 -m bash_kernel.install

sudo cp jupyter.service /lib/systemd/system/
sudo chmod 644 /lib/systemd/system/jupyter.service
sudo systemctl daemon-reload
sudo systemctl enable jupyter.service
service jupyter start
```

### Jupyter Configuration

We generate a jupyter notebook configuration directory and in it a file called jupyter_notebook_config.py that holds the configuration settings for our notebook server. We also create a folder notebooks in the home directory of user jns as the notebook_dir for our server. In the notebook configuration file, we apply the following changes:

- we tell jupyter not to sart a browser upon start - we access the server from a remote machine
- we set the IP address to '*'
- we set the port for the notbook server to listen on to 8888 (which is the default)ebeboo
- we enable mathjax for rendering math in notebooks
- we set the notebook_dir to ~/notebooks, the directory we created
- we use the password hash for the default server password jns

NOTE: this setup still uses password authentication. If you prefer token-based authentication as introduced with notebook version 4.3.0 please check this blog post on on the official Jupyter website: <http://blog.jupyter.org/2016/12/21/jupyter-notebook-4-3-1/>

To change settings, just edit ./jupyter/jupyter_notebook_config.py to suit your needs.

```bash
#!/bin/bash
# script name:     configure_jupyter.sh
# last modified:   2017/03/30
# sudo:            no

if [ $(id -u) = 0 ]
then
   echo "to be run as normal User"
   exit 1
fi

# generate config and create notebook directory
# if notebook directory exists, we keep it (-p)
# if configuration file exeists, we overwrite it (-y)

jupyter notebook -y --generate-config
cd $HOME
mkdir -p notebooks

target=~/.jupyter/jupyter_notebook_config.py

# set up dictionary of changes for jupyter_config.py
declare -A arr
app='c.NotebookApp'
arr+=(["$app.open_browser"]="$app.open_browser = False")
arr+=(["$app.ip"]="$app.ip ='*'")
arr+=(["$app.port"]="$app.port = 8888")
arr+=(["$app.enable_mathjax"]="$app.enable_mathjax = True")
arr+=(["$app.notebook_dir"]="$app.notebook_dir = '/home/${LOGNAME}/notebooks'")
arr+=(["$app.password"]="$app.password = 'sha1:5815fb7ca805:f09ed218dfcc908acb3e29c3b697079fea37486a'")

# apply changes to jupyter_notebook_config.py

for key in ${!arr[@]};do
    if grep -qF $key ${target}; then
        # key found -> replace line
        sed -i "/${key}/c ${arr[${key}]}" $target
    else
        # key not found -> append line
        echo "${arr[${key}]}" >> $target
    fi
done
```

To enable the clusters tab in the notebook interface run:

```bash
sudo ipcluster nbextension enable
```

To enable ipywidgets run: `sudo jupyter nbextension enable --py --sys-prefix widgetsnbextension`

### Installation of Scientific Stack

The list of packages istalled here is just a suggestion. Feel free to adjust as needed.

```bash
#!/bin/bash
# script name:     install_stack.sh
# last modified:   2017/03/05
# sudo:            yes

if ! [ $(id -u) = 0 ]; then
   echo "to be run with sudo"
   exit 1
fi

pip3 install numpy
pip3 --no-cache-dir install matplotlib
pip3 install sympy
pip3 install pandas
pip3 install numexpr
pip3 install bottleneck
pip3 install SQLAlchemy
pip3 install openpyxl
pip3 install xlrd
pip3 install xlwt
pip3 install XlsxWriter
pip3 install beautifulsoup4
pip3 install html5lib

#------------------------------------------------------
apt-get -y install libxml2-dev libxslt-dev
#------------------------------------------------------

pip3 install lxml
pip3 install requests
pip3 install networkx
pip3 install plotly

#-----------------------------------------------------
apt-get -y install libblas-dev liblapack-dev
apt-get -y install libatlas-base-dev gfortran
#-----------------------------------------------------

pip3 install scipy
```

## Keeping Your Installation up-to-date

Occasionally you may want to check for software updates for both the operating system and the python python packages we installed.

### Operating System

```bash
sudo apt-get update
sudo apt-get upgrade
```

### Python Packages

List outdated packages and if there are any, update them individually. Here we assume that package xyz is to be updated after the check:

```bash
pip3 list --outdated --format='legacy'
sudo pip3 install xyz --upgrade
```

The script below automates the process: It genereates a list of outdated (pip3 installed) packages and subsequently processes the list to conduct upgrades.

```bash
#!/bin/bash
# script name:     upgrade_jns.sh
# last modified:   2017/03/30
# sudo:            no

if [ $(id -u) = 0 ]; then
   echo "to be run with no sudo"
   exit 1
fi

START=$SECONDS

sudo apt-get update
sudo apt-get upgrade

# generate list of outdated packages
echo ">>> CHECKING INSTALLATION FOR OUTDATED PACKAGES..."
lst=(`pip3 list --outdated --format='legacy'|grep -o '^\S*'`)

# process list of outdated packages
if [ ${#lst[@]} -eq 0 ]; then
    echo ">>> PIP INSTALLATION UP TO DATE"
else
    echo ">>> PIP UPGRADING PACKAGES"
    for i in ${lst[@]}; do
      sudo pip3 install ${i} --upgrade
    done
fi
if [[ -d $HOME/cloud9 ]]; then
  cd ${HOME}/cloud9
  git pull origin master
  ./scripts/install-sdk.sh
  cd -
fi
if [[ -f /usr/bin/node-red ]]; then
  curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > /tmp/update-nodejs-and-nodered
  chmod u+x /tmp/update-nodejs-and-nodered
  ./expect_nodered.sh
fi
ELAPSED=$(($SECONDS - $START))
echo $ELAPSED
```

### OpenSSH Host Keys

To regenerate host keys, delete the old keys and reconfigure openssh-server. It is safe to run the commands over remote ssh based session. Your existing session shouldn't be interrupted:

```bash
sudo rm /etc/ssh/ssh_host*
sudo dpkg-reconfigure openssh-server
```
