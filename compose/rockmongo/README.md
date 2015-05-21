Rockmongo web-client running in Docker container using docker-compose
=====================================================

## Quick Start
 * `docker-compose up -d` to run proxy in the background
 * Check the webapp is running

## Features
 * Path to configuration file is set to `./config.php` folder, edit to taste to connect to the desired mongo server
 * WebUI server port isset by default to `80` and can be changed in `docker-compose.yml`

## Commands
 * `docker-compose up -d` to run Rockmongo in the background
 * `docker-compose run rockmongo env` to check the internal environment variables