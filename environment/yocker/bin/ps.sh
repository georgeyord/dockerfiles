#!/bin/bash

TARGET_PATH='/root/codebase/georgeyord/dockerfiles/environment/yocker/bin/nginx/html/status/ps.txt'

while true; do
  clear
  docker ps -a > $TARGET_PATH
  cat $TARGET_PATH
  sleep 10;
done
