#!/usr/bin/env bash

# Be extra strict
set -o errexit
set -o nounset
if [[ "${DEBUG_FLAG:-}" == "true" ]]; then
  set -o xtrace
fi

if [ "$1" = 'bash' ]; then
    exec bash "$@"
fi

if [[ "${UID:-}" != "" ]]; then
  if [[ "${GID:-}" == "" ]]; then
    GID="${UID}"
  fi
  if [[ "${USERNAME:-}" == "" ]]; then
    USERNAME="myuser"
  fi
  set +o errexit
  getent passwd "${USERNAME}"
  USER_EXISTS="$?"
  set -o errexit
  if [ "${USER_EXISTS}" == "0" ]; then
    echo "User ${USERNAME} (${UID}/${GID}) already exists, bypassing configuration..."
  else
    echo "Prepare user namespace for user ${UID}/${GID}"
    groupadd -g "${GID}" "${USERNAME}"
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    useradd --system \
            --create-home \
            --home-dir /myhome \
            --uid "${UID}" \
            --gid "${GID}" \
            --password "${USER_PASSWORD}" \
            --groups "sudo,docker" \
            "${USERNAME}"
    id "${USERNAME}" -nG
  fi
else
  USERNAME="$(whoami)"
fi

if [ -f /prepare.sh ]; then
  echo "Run prepare script..."
  /usr/bin/bash /prepare.sh
fi

echo "Start GoTTY..."
args=("$@")

exec /usr/sbin/gosu \
  "${USERNAME}:${USERNAME}" \
  /usr/local/bin/gotty \
    --config /.gotty \
    ${GOTTY_OPTIONS:-} \
    "${args[@]}"
