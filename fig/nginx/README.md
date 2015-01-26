Nginx server in Docker container using [Fig](http://www.fig.sh)
=====================================================

## Quick Start
 * Run `fig up -d`
 * Check the webapp is running in localhost

## Features
 * Path to codebase is set to `./data` folder and can be changed in `fig.yml`
 * Nginx port isset by default to `80` and can be changed in `fig.yml`

## Commands
 * `fig up` to run nginx server in the foreground
 * `fig up -d` to run nginx server in the background
 * `fig run nginx env` to check the internal environment variables