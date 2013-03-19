#! /bin/bash

# desc: Plays/Records MP3 stream

set -u -e

SCRIPT_DIR=$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd ) 
source $SCRIPT_DIR/recorder-player.conf

init_player()
{
  for i in `seq 1 2`; do
    PING=$(ping -c $PINGCOUNT -W 2000 $PING_HOST | grep received | cut -d ',' -f2 | cut -d ' ' -f2)        
    PING=${PING:-0}
    echo "Ping response: $PING"
    if [ $PING -eq 0 ]; then
      sleep 10
      echo "no inet"
    else
      record
      return 0
    fi
  done
  play
}

record()
{
  STREAM_URL=$(choose_stream)
  echo "STREAM_URL: $STREAM_URL"
  cd $MUSIC_DIR/Radio
  echo "killing processes..."
  kill_process icecream
  kill_process mpg123
  echo "starting recording..."
  nohup icecream -t --stdout $STREAM_URL | mpg123 - > $LOGGER 2>&1 &
  echo "recording started"
}

play()
{
  touch $PLAYLIST
  find $MUSIC_DIR/ -type f -name '*.mp3' | sort -R > $PLAYLIST
  kill_process mpg123
  mpg123 -@ $PLAYLIST
}

choose_stream()
{
  # download latest playlist of streams
  RAND_STREAM=$(curl -s $STREAMS_LIST_URL | grep -v '#' | sort -R | tail -n1)
  RAND_URL=$(curl -s $RAND_STREAM | grep 'http:' | awk -F'=' '{print $2}' | head -n1)
  echo "${RAND_URL%/}"
}

kill_process()
{
  PROCESS=$1
  echo "killing process $PROCESS"
  if [ "$(sudo pgrep -c $PROCESS)" = "0" ]; then 
    echo "process $PROCESS not running"
  else
    PID=$(sudo pgrep $PROCESS)
    echo "process $PROCESS running, PID: $PID, killing"
    sudo kill -9 $PID
  fi
}

# MAIN]
init_player
sudo amixer cset numid=1 -- ${VOLUME}%

