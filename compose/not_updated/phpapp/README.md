Nginx server with Php-fpm in Docker container using docker-compose
=====================================================

## Quick Start
 * Run `docker-compose up -d`
 * Check the webapp running in localhost and that you see the phpinfo() output

## Features
 * Path to codebase is set to `./data` folder and can be changed in `docker-compose.yml`
 * Nginx port isset by default to `80` and can be changed in `docker-compose.yml`
 * Nginx logs are persistent and accessible from host in `./log/nginx` folder

## Commands
 * `docker-compose up` to run both services in the foreground
 * `docker-compose up -d` to run both services in the background
 * `docker-compose run nginx env` to check the internal environment variables