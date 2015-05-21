#!/bin/bash

docker-compose $*

if [[ $(uname) == "Linux" ]]; then
    sudo rm -f data/h2/prodDb.lock.db
fi