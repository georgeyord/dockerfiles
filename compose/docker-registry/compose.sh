#!/bin/bash

FILE=./data/keys/ssl.pem

if [ -f $FILE ]; then
   echo "SSL pem file exists, continuing..."
else
   echo "SSL pem file not found, we will generate one..."
   openssl genrsa 2048 > ssl.key
   openssl req -new -x509 -nodes -sha1 -days 3650 -key ssl.key > ssl.pem
fi

docker-compose $*

if [[ $(uname) == "Linux" ]]; then
    sudo rm -f data/h2/prodDb.lock.db
fi