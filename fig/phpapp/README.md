Nginx server with Php-fpm in Docker container using [Fig](http://www.fig.sh)
=====================================================

## Quick Start
 * Run `fig up -d`
 * Check the webapp running in localhost and that you see the phpinfo() output

## Features
 * Path to codebase is set to `./data` folder and can be changed in `fig.yml`
 * Nginx port isset by default to `80` and can be changed in `fig.yml`
 * Nginx logs are persistent and accessible from host in `./log/nginx` folder

## Commands
 * `fig up` to run both services in the foreground
 * `fig up -d` to run both services in the background
 * `fig run nginx env` to check the internal environment variables