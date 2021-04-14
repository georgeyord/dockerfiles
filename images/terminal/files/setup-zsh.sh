#!/usr/bin/env bash

CURRENT_DIR="$(pwd)"

/zsh-in-docker.sh \
  -t https://github.com/denysdovhan/spaceship-prompt \
  -p git \
  -p docker \
  -p docker-compose \
  -p aws \
  -p gcloud \
  -p kubectl \
  -p terraform \
  -p https://github.com/zsh-users/zsh-autosuggestions \
  -p https://github.com/zsh-users/zsh-completions \
  -p https://github.com/zsh-users/zsh-history-substring-search \
  -p https://github.com/zsh-users/zsh-syntax-highlighting \
  -p 'history-substring-search' \
  -a 'bindkey "\$terminfo[kcuu1]" history-substring-search-up' \
  -a 'bindkey "\$terminfo[kcud1]" history-substring-search-down'

cd "${CURRENT_DIR}" || true

/bin/zsh
