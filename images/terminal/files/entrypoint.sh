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

    # exec /usr/sbin/gosu \
    # "${USERNAME}:${USERNAME}" \
    # sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v${ZSH_IN_DOCKER_VERSION}/zsh-in-docker.sh)" -- \
    #   -t https://github.com/denysdovhan/spaceship-prompt \
    #   -a 'SPACESHIP_PROMPT_ADD_NEWLINE="false"' \
    #   -a 'SPACESHIP_PROMPT_SEPARATE_LINE="false"' \
    #   -p https://github.com/zsh-users/zsh-autosuggestions \
    #   -p https://github.com/zsh-users/zsh-completions \
    #   -p https://github.com/zsh-users/zsh-history-substring-search \
    #   -p https://github.com/zsh-users/zsh-syntax-highlighting \
    #   -p 'history-substring-search'
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
