#!/bin/bash

if [ -z "${ABAO_ARGUMENTS}" ]; then
  echo "Enviromental variable ABAO_ARGUMENTS is required, exiting..."
  exit 1
fi

echo "Abao will run every ${LOOP_DELAY} seconds from previous completion."
sleep 1
ITERATION=1

trap "exit" INT
while :
do
    abao ${ABAO_ARGUMENTS}
    ITERATION=$((ITERATION+1))
    echo "Abao will start iteration ${ITERATION} in ${LOOP_DELAY} seconds."
    sleep ${LOOP_DELAY}
done
