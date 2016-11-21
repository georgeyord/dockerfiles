#!/bin/bash

INIT_OVERRIDE_FILE=/tmp/init.sh

if [ -f "${INIT_OVERRIDE_FILE}" ] && [[ "${INIT_OVERRIDE_FILE}" != "${BASH_SOURCE}" ]]; then
	echo "Init overriding file found at ${INIT_OVERRIDE_FILE}!"
	source "${INIT_OVERRIDE_FILE}" $*
else
	CURRENT_PATH=`pwd`

	if [ -n "$SSL_ACTIVE" ]; then
		if [ -f $SSL_CERT_PATH/nginx.key ]; then
		   echo "SSL files exist, continuing..."
		else
		   echo -e  "SSL files not found, let's generate them.\n\nYOU MUST RUN DOCKER IN INTERACTIVE MODE TO SET THIS UP, HIT CTRL+C TO EXIT IF IN DEAMON MODE..."
		   mkdir -p $SSL_CERT_PATH
       cd $SSL_CERT_PATH
		   openssl genrsa 2048 > nginx.key
		   openssl req -new -x509 -nodes -sha1 -days 3650 -key nginx.key > nginx.crt
		   echo "SSL files were created, exiting to start in deamon mode..."
       exit 0
		fi

		echo -e "Https activated"
  	export SSL_PLACEHOLDER="listen 443 ssl;
  ssl_certificate ${SSL_CERT_PATH}/nginx.crt;
  ssl_certificate_key ${SSL_CERT_PATH}/nginx.key;"
	else
		export SSL_PLACEHOLDER=''
	fi

	if [ -n "$HTPASSWD_PASSWORD" ]; then
		echo -e "Basic authentication activated\nUsername: ${HTPASSWD_USER}\nPassword: ${HTPASSWD_PASSWORD}"
		htpasswd -b -c ${HTPASSWD_PATH} ${HTPASSWD_USER} ${HTPASSWD_PASSWORD}
  	export HTPASSWD_PLACEHOLDER="auth_basic \"Restricted\";
    auth_basic_user_file ${HTPASSWD_PATH};
		"
		echo $HTPASSWD_PLACEHOLDER
	else
		export HTPASSWD_PLACEHOLDER=''
	fi

  # Finalize default.conf using enviromental variables
	envsubst '$NGINX_ERROR_LEVEL' < /templates/nginx.conf.tpl > /etc/nginx/nginx.conf
  envsubst '$PUBLIC_HOST,$PUBLIC_PORT,$SERVED_PATH,$SSL_PLACEHOLDER,$HTPASSWD_PLACEHOLDER' < /templates/default.conf.tpl > /etc/nginx/conf.d/default.conf

	echo -e "\n\nNginx configuration file:"
	cat /etc/nginx/nginx.conf
	sleep 1

	echo -e "\n\nVhost configuration file:"
	cat /etc/nginx/conf.d/default.conf

  # Start nginx in the foreground
  nginx
fi
