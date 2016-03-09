#!/bin/bash

# elasticsearch start
/usr/share/elasticsearch/bin/elasticsearch -d

# nginx/kibana start
/usr/sbin/nginx -c /etc/nginx/nginx.conf

# td-agent start
td-agent