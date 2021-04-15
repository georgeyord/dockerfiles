#!/usr/bin/env bash

# Be extra strict
set -o errexit
set -o nounset
if [[ "${DEBUG_FLAG:-}" == "true" ]]; then
  set -o xtrace
fi

if [ "${1:-}" = 'bash' ]; then
    exec bash "$@"
fi

if [[ "${USER_ID:-}" != "" ]]; then
  if [[ "${USER_NAME:-}" == "" ]]; then
    USER_NAME="myuser"
  fi
  if [[ "${GROUP_ID:-}" == "" ]]; then
    GROUP_ID="${USER_ID}"
  fi
  set +o errexit
  getent passwd "${USER_NAME}"
  USER_EXISTS="$?"
  set -o errexit
  if [ "${USER_EXISTS}" == "0" ]; then
    echo "User ${USER_NAME} (${USER_ID}/${GROUP_ID}) already exists, bypassing setup..."
  else
    if [[ "${USER_HOME:-}" == "" ]]; then
      USER_HOME="/myhome"
    fi
    mkdir -p "${USER_HOME}"

    echo "Prepare user namespace for user '${USER_NAME}' (${USER_ID}/${GROUP_ID})"
    groupadd -g "${GROUP_ID}" "${USER_NAME}" || true

    if [[ "${SUDO_WITHOUT_PASSWORD}" == "true" ]]; then
      echo "Prepare sudo privileges without password."
      echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
    fi

    useradd --system \
            --create-home \
            --home-dir "${USER_HOME}" \
            --uid "${USER_ID}" \
            --gid "${GROUP_ID}" \
            --groups "sudo" \
            --shell "${SHELL}" \
            "${USER_NAME}"

    id "${USER_NAME}" -nG
    chown "${USER_ID}:${GROUP_ID}" "${USER_HOME}"
    cd "${USER_HOME}"
  fi
else
  USER_NAME="$(whoami)"
fi

if [ -f /prepare.sh ]; then
  echo "Run prepare script..."
  /bin/bash /prepare.sh
fi

echo "Start GoTTY..."
args=("$@")

exec /usr/sbin/gosu \
  "${USER_NAME}" \
  /usr/local/bin/gotty \
    --config /.gotty \
    ${GOTTY_OPTIONS:-} \
    "${args[@]}"
