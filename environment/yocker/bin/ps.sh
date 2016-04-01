#!/bin/bash

CURRENT_PATH=`pwd`
TARGET_PATH="${CURRENT_PATH}/bin/nginx/www/status/ps.txt"
DELIMITER = "\n==============================================================\n"

if [ -z "$1" ]; then
  TIMEOUT = 10
else
  TIMEOUT = $1
fi

while true; do
  clear
  docker ps -as > $TARGET_PATH
  cat $TARGET_PATH
  echo -e $DELIMITER >> $TARGET_PATH
  free -m >> $TARGET_PATH
  sleep $TIMEOUT;
done
