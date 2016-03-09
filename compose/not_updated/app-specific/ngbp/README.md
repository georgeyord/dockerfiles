Nginx server in Docker container to run [NgBoilerplate](https://github.com/ngbp/ngbp) using docker-compose
=====================================================

## Quick Start
 * Clone [ngbp](https://github.com/ngbp/ngbp) repo to `data` folder `git clone https://github.com/ngbp/ngbp.git data`
 * Install npm dependencies `docker-compose run webhelper npm install`
 * Install bower dependencies `docker-compose run webhelper bower install --allow-root`
 * Run grunt to build the webapp `docker-compose run webhelper grunt build --force`
 * Run `docker-compose up` and check the webapp running in localhost

## Features
 * Path to codebase is set to `./data/build` folder and can be changed in `docker-compose.yml`
 * Nginx port isset by default to `80` and can be changed in `docker-compose.yml`

## Commands
 * `docker-compose run webhelper [npm/bower/grunt commands]` to run npm/bower/grunt commands
 * `docker-compose up` to run nginx server in the foreground
 * `docker-compose up -d` to run nginx server in the background
 * `docker-compose run ngbp env` to check the internal environment variables