#! /bin/bash

# ME=$(whoami)

# Which branch should be loaded
branch=$(cat $HOME/.raspberry-edu-devops.branch)
# Load and merge new version
git pull
# Download objects from repro
git fetch origin
# Switch to branch and reset do origin. Remove untracked directories/files
git checkout $branch && git reset --hard origin/$branch && git clean -f -d

# Set permissions for shell skripts
chmod -R 744 *.sh
