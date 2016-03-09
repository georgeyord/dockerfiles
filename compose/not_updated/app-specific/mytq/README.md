Nginx server with Php-fpm in Docker container using docker-compose
=====================================================

## Features
 * Path to codebase is set to `./data/mytq` folder and can be changed in `docker-compose.yml`
 * Nginx port isset by default to `80` and can be changed in `docker-compose.yml`
 * Nginx logs are persistent and accessible from host in `./log/nginx` folder

## Commands
 * `docker-compose up` to run both services in the foreground
 * `docker-compose up -d` to run both services in the background
 * `docker-compose run nginx env` to check the internal environment variables