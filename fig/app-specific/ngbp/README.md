Nginx server in Docker container to run [NgBoilerplate](https://github.com/ngbp/ngbp) using [Fig](http://www.fig.sh)
=====================================================

## Quick Start
 * Clone [ngbp](https://github.com/ngbp/ngbp) repo to `data` folder `git clone https://github.com/ngbp/ngbp.git data`
 * Install npm dependencies `fig run webhelper npm install`
 * Install bower dependencies `fig run webhelper bower install --allow-root`
 * Run grunt to build the webapp `fig run webhelper grunt build --force`
 * Run `fig up` and check the webapp running in localhost

## Features
 * Path to codebase is set to `./data/build` folder and can be changed in `fig.yml`
 * Nginx port isset by default to `80` and can be changed in `fig.yml`

## Commands
 * `fig run webhelper [npm/bower/grunt commands]` to run npm/bower/grunt commands
 * `fig up` to run nginx server in the foreground
 * `fig up -d` to run nginx server in the background
 * `fig run ngbp env` to check the internal environment variables