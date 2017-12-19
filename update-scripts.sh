#! /bin/bash -l

# script name:     update-scripts.sh
# sudo:            no
set -x
echo "Run update-scripts.sh"
echo "If index.lock exists remove it"
sudo rm -rf index.lock || true
echo "Which branch should be loaded"
branch=$(cat $HOME/.raspberry-edu-devops.branch || echo master)
echo "Load and merge new version"
git pull
echo "Download objects from repro"
git fetch origin
echo "Switch to branch and reset do origin. Remove untracked directories/files"
git checkout $branch && git reset --hard origin/$branch && git clean -f -d

echo "Set permissions for shell skripts"
chmod -R 744 *.sh
set +x
