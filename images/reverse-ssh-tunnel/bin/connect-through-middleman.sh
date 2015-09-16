#!/bin/bash

if [ -z "$ROOT_PASS" ]; then
  echo "ROOT_PASS env variable should be set to the middleman password exiting..."
  exit 1
fi

if [ -z "$PUBLIC_HOST_ADDR" ]; then
  echo "PUBLIC_HOST_ADDR env variable should be set to the middleman's public-ip or domanin name, eg. 'mydocker.co', exiting..."
  exit 1
fi

if [ -z "$PUBLIC_HOST_PORT" ]; then
  echo "PUBLIC_HOST_PORT env variable should be set to the middleman's public port, eg. '22', exiting..."
  exit 1
fi

if [ -z "$DESTINATION_USER" ]; then
  echo "DESTINATION_USER env variable should be set to the destination user, eg. 'user', exiting..."
  exit 1
fi

if [ -z "$PROXY_PORT" ]; then
  echo "PROXY_PORT env variable should be set to the SSH port at the middleman used to forward SSH connection to destination server, exiting..."
  exit 1
fi

KNOWN_HOSTS="/root/.ssh/known_hosts"
ssh-keyscan -p ${PUBLIC_HOST_PORT} -H ${PUBLIC_HOST_ADDR} > ${KNOWN_HOSTS}

echo "Command to run: 'sshpass -p ${ROOT_PASS} ssh -t -p ${PUBLIC_HOST_PORT} root@${PUBLIC_HOST_ADDR} \"ssh ${DESTINATION_USER}@localhost -p ${PROXY_PORT}\"'"
sshpass -p ${ROOT_PASS} ssh -t -p ${PUBLIC_HOST_PORT} root@${PUBLIC_HOST_ADDR} "ssh ${DESTINATION_USER}@localhost -p ${PROXY_PORT}"
