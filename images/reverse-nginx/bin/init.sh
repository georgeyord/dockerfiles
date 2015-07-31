#!/bin/bash

# Finalize default.conf using enviromental variables
envsubst '$PUBLIC_PORT,$TARGET_HOST,$TARGET_PORT' < /etc/nginx/conf.d/default.conf.tpl > /etc/nginx/conf.d/default.conf

# Echo error/access log to stdout
tailf /var/log/nginx/access.log &
tailf /var/log/nginx/error.log &

# Start nginx in the foreground
nginx