#!/bin/bash

function getInput() {
    if [ -z "${1}" ]; then
        FN_QUESTION="Set value: "
    else
        FN_QUESTION=$1
    fi

    while true; do
        read -p "$FN_QUESTION " FN_ANSWER
        if [[ -n $FN_ANSWER ]]; then
            echo $FN_ANSWER
            break;
        fi
    done
}

# Create SSL certificates for UI
UI_CERT_PATH=./data/keys

mkdir -p $UI_CERT_PATH
if [ -f $UI_CERT_PATH/ssl.pem ]; then
   echo "SSL pem file exists, continuing..."
else
   echo "SSL pem file not found, we will generate one..."
   mkdir -p $UI_CERT_PATH/ssl.pem
   openssl genrsa 2048 > $UI_CERT_PATH/ssl.key
   openssl req -new -x509 -nodes -sha1 -days 3650 -key ssl.key > $UI_CERT_PATH/ssl.pem
fi

# Create basic auth username/password for proxy
AUTH_PASSWORD_PATH=./data/auth
AUTH_PASSWORD_FILENAME=docker-registry.htpasswd

mkdir -p $AUTH_PASSWORD_PATH
if [ -f $AUTH_PASSWORD_PATH/$AUTH_PASSWORD_FILENAME ]; then
   echo "Auth file pem file exists, continuing..."
else
   echo "Auth file file not found, we will generate one..."
   AUTH_USER=$(getInput "Username: ")
   AUTH_PASSWORD=$(getInput "Password: ")
   htpasswd -bc $AUTH_PASSWORD_PATH/$AUTH_PASSWORD_FILENAME $AUTH_USER $AUTH_PASSWORD
fi


# Create SSL certificates for proxy
PROXY_CERT_PATH=./data/SSL

mkdir -p $PROXY_CERT_PATH
if [ -f $PROXY_CERT_PATH/server-key.pem ]; then
   echo "SSL files exists, continuing..."
else
    echo "SSL files not found, we will generate them..."
    mkdir -p $PROXY_CERT_PATH/ssl.pem
	sudo apt-get install apache2-utils
	echo 01 > $PROXY_CERT_PATH/ca.srl
	openssl genrsa -des3 -out $PROXY_CERT_PATH/ca-key.pem 2048 
	openssl req -new -x509 -days 365 -key $PROXY_CERT_PATH/ca-key.pem -out $PROXY_CERT_PATH/ca.pem
	openssl genrsa -des3 -out $PROXY_CERT_PATH/server-key.pem 2048
	openssl req -subj ‘/CN=<Your Hostname Here>’ -new -key server-key.pem -out server.csr 
	PROXY_HOSTNAME=$(getInput "Hostname: ")
	openssl req -subj "/CN=$PROXY_HOSTNAME" -new -key $PROXY_CERT_PATH/server-key.pem -out $PROXY_CERT_PATH/server.csr 
	openssl x509 -req -days 365 -in $PROXY_CERT_PATH/server.csr -CA ca.pem -CAkey $PROXY_CERT_PATH/ca-key.pem -out $PROXY_CERT_PATH/server-cert.pem
	openssl rsa -in $PROXY_CERT_PATH/server-key.pem -out $PROXY_CERT_PATH/server-key.pem
	sudo mkdir -p /etc/ssl/certs
	sudo touch /etc/ssl/certs/ca-certificates.crt
	sudo cat ca.pem >> /etc/ssl/certs/ca-certificates.crt
fi

docker-compose $*

if [[ $(uname) == "Linux" ]]; then
    sudo rm -f data/h2/prodDb.lock.db
fi