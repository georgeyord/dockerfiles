#!/bin/bash

docker-compose $*

sudo rm -f data/h2/prodDb.lock.db
