Helper for web applications built in a Docker container using [Fig](http://www.fig.sh)
=====================================================

## Includes
 * nodejs
 * npm
 * bower
 * grunt cli

## Commands
 * `fig run webhelper env` to check the internal environment variables
 * `fig run webhelper npm install` to run npm install
 * `fig run webhelper bower install` to run bower install
 * `fig run webhelper grunt build` to run grunt build
 * ...etc

## Notices
 * grunt will not succeed running Browser tests
 * Live reload needs somw tweaking to work