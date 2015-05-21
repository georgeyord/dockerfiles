Nginx server used as Proxypass in Docker container using docker-compose
=====================================================

## Quick Start
 * `docker-compose up -d` to run proxy in the background
 * Check the produced file in `conf/default`

## Features
 * Nginx port isset by default to `80` and can be changed in `docker-compose.yml`
 * Nginx auto-created configuration file is persistent and accessible from host in `./conf/default` (don't edit, will be deleted when new nginx Docker containers run)

## Commands
 * `docker-compose up` to run proxy in the foreground
 * `docker-compose up -d` to run proxy in the background
 * `docker-compose run proxy env` to check the internal environment variables