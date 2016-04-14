#!/bin/bash

CURRENT_PATH=`pwd`
SCRIPT_PATH=`dirname $0`
SSL_FOLDER="${SCRIPT_PATH}/../data/nginx/ssl"
HTPASSWD_FOLDER="${SCRIPT_PATH}/../data/nginx/htpasswd"
mkdir -p ${HTPASSWD_FOLDER}

if [ -f $SSL_FOLDER/nginx.key ]; then
   echo "SSL files exist, continuing..."
else
   mkdir -p ${SSL_FOLDER}
   openssl genrsa 2048 > "${SSL_FOLDER}/nginx.key"
   openssl req -new -x509 -nodes -sha1 -days 3650 -key "${SSL_FOLDER}/nginx.key" > "${SSL_FOLDER}/nginx.crt"
   echo "SSL files were created at ${SSL_FOLDER}."
fi


if [ -f ${HTPASSWD_FOLDER}/default ]; then
   echo "HTPASSWD file exist, continuing..."
else
  if [ -z ${BASIC_AUTH_USER} ]; then
    echo "Before continuing, please set the basic auth username like this: 'export BASIC_AUTH_USER=[user]', exiting..."
    exit 1
  fi

  if [ -z ${BASIC_AUTH_PASSWORD} ]; then
    echo "Before continuing, please set the basic auth password like this: 'export BASIC_AUTH_PASSWORD=[password]', exiting..."
    exit 1
  fi

	htpasswd -b -c ${HTPASSWD_FOLDER}/default ${BASIC_AUTH_USER} ${BASIC_AUTH_PASSWORD}
	echo "HTPASSWD file was created at ${HTPASSWD_FOLDER}."
fi
