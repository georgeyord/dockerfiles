Nginx server in Docker container using docker-compose
=====================================================

## Quick Start
 * Run `docker-compose up -d`
 * Check the webapp is running in localhost

## Features
 * Path to codebase is set to `./data` folder and can be changed in `docker-compose.yml`
 * Nginx port isset by default to `80` and can be changed in `docker-compose.yml`

## Commands
 * `docker-compose up` to run nginx server in the foreground
 * `docker-compose up -d` to run nginx server in the background
 * `docker-compose run nginx env` to check the internal environment variables