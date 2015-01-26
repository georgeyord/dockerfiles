Rockmongo web-client running in Docker container using [Fig](http://www.fig.sh)
=====================================================

## Quick Start
 * `fig up -d` to run proxy in the background
 * Check the webapp is running

## Features
 * Path to configuration file is set to `./config.php` folder, edit to taste to connect to the desired mongo server
 * WebUI server port isset by default to `80` and can be changed in `fig.yml`

## Commands
 * `fig up -d` to run Rockmongo in the background
 * `fig run rockmongo env` to check the internal environment variables