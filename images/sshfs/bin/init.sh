#! /bin/bash

if [ -z "${TARGET_URL}" ]; then
    echo "Enviromental variable TARGET_URL is required, exiting..."
    exit 1
fi
echo "Target url: ${TARGET_URL}"

if [ -n "${TARGET_PORT}" ]; then
  echo "Target port: ${TARGET_PORT}"
  PLACEHOLDER_PORT="-p ${TARGET_PORT} "
else
  PLACEHOLDER_PORT=""
fi

if [ -z "${TARGET_PATH}" ]; then
    echo "Enviromental variable TARGET_PATH is required, exiting..."
    exit 1
fi

echo "Target path: ${TARGET_PATH}"
mkdir -p ${TARGET_PATH}

echo "Target user: ${TARGET_USER}"
gpasswd -a ${TARGET_USER} fuse

if [ -f /root/.ssh/id_rsa ]; then
  echo "Ssh key found at '/root/.ssh/id_rsa'"
  PLACEHOLDER_SSH_KEY="-o IdentityFile=/root/.ssh/id_rsa"
else
  PLACEHOLDER_SSH_KEY=""
fi

echo "sshfs ${PLACEHOLDER_SSH_KEY} ${PLACEHOLDER_PORT} ${TARGET_USER}@${TARGET_URL}:${TARGET_PATH} /remote"
sshfs ${PLACEHOLDER_SSH_KEY} \
      ${PLACEHOLDER_PORT} \
      ${TARGET_USER}@${TARGET_URL}:${TARGET_PATH} /remote

if [[ $? -eq 0 ]]; then
  tailf /var/log/lastlog
fi
