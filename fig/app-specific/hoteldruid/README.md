Nginx server with Php-fpm in Docker to run Hoteldruid booking management software using [Fig](http://www.fig.sh)
=====================================================

## Quick Start
 * Download codebase from [www.hoteldruid.com](http://www.hoteldruid.com/en/download.html) to `data/hoteldruid` folder
 * `fig up -d` to run nginx server in the background
 * Check the webapp is running in localhost
 * Follow the on-screen instructions (don't change the configuration of mysql connection)

## Features
 * Path to Hoteldruid codebase is set to `./data/hoteldruid` folder and can be changed in `fig.yml`
 * Nginx port isset by default to `80` and can be changed in `fig.yml`
 * Nginx logs are persistent and accessible from host in `./log/nginx` folder

## Commands
 * `fig up` to run both services in the foreground
 * `fig up -d` to run both services in the background
 * `fig run [hoteldruid|mysql] env` to check the internal environment variables
 * `fig run mysql sh -c 'exec mysql -h"mysql_mysql_1" -P"$MYSQL_PORT_3306_TCP_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"'` to run mysql client and connect to the running server