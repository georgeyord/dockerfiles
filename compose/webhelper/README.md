Helper for web applications built in a Docker container using docker-compose
=====================================================

## Includes
 * nodejs
 * npm
 * bower
 * grunt cli

## Commands
 * `docker-compose run webhelper env` to check the internal environment variables
 * `docker-compose run webhelper npm install` to run npm install
 * `docker-compose run webhelper bower install` to run bower install
 * `docker-compose run webhelper grunt build` to run grunt build
 * ...etc

## Notices
 * grunt will not succeed running Browser tests
 * Live reload needs somw tweaking to work