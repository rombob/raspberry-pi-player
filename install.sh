#!/bin/bash

# desc: install player

set -u -e

TS=$(date +%s)
BUILD_FOLDER=/home/pi/recorder-player-versions/$TS
PLAYER_FILENAME=recorder-player.sh
PLAYER_CONF_FILENAME=recorder-player.conf
REMOTE_PATH=https://raw.github.com/rombob/raspberry-pi-player/src

mkdir -p $BUILD_FOLDER
cd $BUILD_FOLDER
wget $REMOTE_PATH/$PLAYER_FILENAME
wget $REMOTE_PATH/$PLAYER_CONF_FILENAME
chmod +x $PLAYER_FILENAME
rm -f /home/pi/$PLAYER_FILENAME /home/pi/$PLAYER_CONF_FILENAME
ln -s $BUILD_FOLDER/$PLAYER_FILENAME /home/pi/$PLAYER_FILENAME
ln -s $BUILD_FOLDER/$PLAYER_CONF_FILENAME /home/pi/$PLAYER_CONF_FILENAME
echo "installed"
ls -la $BUILD_FOLDER/$PLAYER_FILENAME $BUILD_FOLDER/$PLAYER_CONF_FILENAME
ls -la /home/pi/$PLAYER_FILENAME /home/pi/$PLAYER_CONF_FILENAME