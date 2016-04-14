#!/bin/bash

CURRENT_PATH=`pwd`
TARGET_FOLDER="${CURRENT_PATH}/bin/nginx/www/status/api"
mkdir -p ${TARGET_FOLDER}

if [[ -z "$1" ]]; then
  TIMEOUT=10
else
  TIMEOUT=$1
fi

while true; do
  clear
  date
  docker ps -as > ${TARGET_FOLDER}/docker_ps.txt
  free -m > ${TARGET_FOLDER}/memory.txt

  API="info"; ENDPOINT="/${API}"; FILEPATH="${TARGET_FOLDER}/${API}.json"
  echo "Creating endpoint $ENDPOINT"; docker-api "${ENDPOINT}" | tail -n +6 > "$FILEPATH"; ls -lsah "$FILEPATH"

  API="containers"; ENDPOINT="/${API}/json"; FILEPATH="${TARGET_FOLDER}/${API}.json"
  echo "Creating endpoint $ENDPOINT"; docker-api "${ENDPOINT}" | tail -n +6 > "$FILEPATH"; ls -lsah "$FILEPATH"

  API="images"; ENDPOINT="/${API}/json"; FILEPATH="${TARGET_FOLDER}/${API}.json"
  echo "Creating endpoint $ENDPOINT"; docker-api "${ENDPOINT}" | tail -n +6 > "$FILEPATH"; ls -lsah "$FILEPATH"

  API="networks"; ENDPOINT="/${API}"; FILEPATH="${TARGET_FOLDER}/${API}.json"
  echo "Creating endpoint $ENDPOINT"; docker-api "${ENDPOINT}" | tail -n +6 > "$FILEPATH"; ls -lsah "$FILEPATH"

  API="version"; ENDPOINT="/${API}"; FILEPATH="${TARGET_FOLDER}/${API}.json"
  echo "Creating endpoint $ENDPOINT"; docker-api "${ENDPOINT}" | tail -n +6 > "$FILEPATH"; ls -lsah "$FILEPATH"

  API="volumes"; ENDPOINT="/${API}"; FILEPATH="${TARGET_FOLDER}/${API}.json"
  echo "Creating endpoint $ENDPOINT"; docker-api "${ENDPOINT}" | tail -n +6 > "$FILEPATH"; ls -lsah "$FILEPATH"

  echo "Sleep for $TIMEOUT"
  sleep "$TIMEOUT";
done