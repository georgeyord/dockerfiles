#!/bin/bash

CERT_PATH=./data/keys

mkdir -p $CERT_PATH
if [ -f $CERT_PATH/ssl.pem ]; then
   echo "SSL pem file exists, continuing..."
else
   echo "SSL pem file not found, we will generate one..."
   mkdir -p $CERT_PATH/ssl.pem
   openssl genrsa 2048 > $CERT_PATH/ssl.key
   openssl req -new -x509 -nodes -sha1 -days 3650 -key ssl.key > $CERT_PATH/ssl.pem
fi

docker-compose $*

if [[ $(uname) == "Linux" ]]; then
    sudo rm -f data/h2/prodDb.lock.db
fi