#!/bin/bash

#
# This script will automatically download Makefile from my repo and configure
# the whole project.
#

# download info
HOST=raw.githubusercontent.com
USER_NAME=ngharry
REPO=cpp-project
BRANCH=master
FILE=Makefile

# Download Makefile
echo "Downloading Makefile..."
curl -O https://$HOST/$USER_NAME/$REPO/$BRANCH/$FILE
echo "Finished."

make configure
