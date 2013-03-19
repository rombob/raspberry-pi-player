raspberry-pi-player
================

### MP3 Stream Player/Recorder Script for Raspberry-Pi ###

- Plays and records mp3 streams when connected to internet
- Plays recorded files while offline

### Install ###

install dependencies

    sudo apt-get install curl mpg123 icecream

install player

    sudo su - pi
    curl -s https://raw.github.com/rombob/raspberry-pi-player/master/install.sh | bash
    
run player
    
    /home/pi/recorder-player.sh

### Load on boot ###

add to /etc/rc.local

    su -c '/home/pi/recorder-player.sh' pi
    
### Files cleanup cron ###

uses ruby

    sudo wget -O /home/pi/clean_names.rb https://raw.github.com/rombob/raspberry-pi-player/master/src/clean_names.rb
    sudo wget -O /etc/cron.d/rpi_player_recorder https://raw.github.com/rombob/raspberry-pi-player/master/cron/rpi_player_recorder
    