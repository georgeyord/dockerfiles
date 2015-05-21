Nginx server with Php-fpm in Docker to run Hoteldruid booking management software using docker-compose
=====================================================

## Quick Start
 * Download codebase from [www.hoteldruid.com](http://www.hoteldruid.com/en/download.html) to `data/hoteldruid` folder
 * `docker-compose up -d` to run nginx server in the background
 * Check the webapp is running in localhost
 * Follow the on-screen instructions (don't change the configuration of mysql connection)

## Features
 * Path to Hoteldruid codebase is set to `./data/hoteldruid` folder and can be changed in `docker-compose.yml`
 * Nginx port isset by default to `80` and can be changed in `docker-compose.yml`
 * Nginx logs are persistent and accessible from host in `./log/nginx` folder

## Commands
 * `docker-compose up` to run both services in the foreground
 * `docker-compose up -d` to run both services in the background
 * `docker-compose run [hoteldruid|mysql] env` to check the internal environment variables
 * `docker-compose run mysql sh -c 'exec mysql -h"mysql_mysql_1" -P"$MYSQL_PORT_3306_TCP_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"'` to run mysql client and connect to the running server