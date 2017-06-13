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
sudo apt-get upgrade --yes

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
