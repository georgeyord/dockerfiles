#!/bin/bash

#####################
##### FUNCTIONS #####
#####################

function install_widgets() {
  WIDGETS=$@
  if [[ ! -z "$WIDGETS" ]]; then
    for WIDGET in $WIDGETS; do
      echo -e "\nInstalling widget from gist $WIDGET"
      dashing install "$WIDGET"
    done
  fi
}

function update_gemfile() {
  GEMS=$@
  if [[ ! -z "$GEMS" ]]; then
    echo -e "\Including gem(s): $GEMS"
    for GEM in $GEMS; do
      echo -e "\ngem '$GEM'" >> Gemfile
    done
  fi
}

function install_gems() {
  if [ ! -f "/dashboard/Gemfile" ]; then
    echo -e "\nInstalling gem(s) using bundle..."
    bundle install --system --jobs 4
  fi
}

#####################
####### MAIN ########
#####################

# Install dashing if missing
if [[ ! -e /dashboard/Gemfile ]]; then
  CURRENT_PATH=`pwd`
  cd /
  gem install dashing && \
  dashing new dashing
  cd "${CURRENT_PATH}"
fi

# Install dependencies
if [[ ! -e /dashboard/installed.lock ]]; then
  install_widgets $WIDGETS
  update_gemfile $GEMS
  touch /dashboard/installed.lock
fi

install_gems

if [[ ! -z "$PORT" ]]; then
  PORT_ARG="-p $PORT"
fi

# Start dashing
exec dashing start $PORT_ARG
