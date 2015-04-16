Etherpad with MySql persistency in Docker container using [Fig](http://www.fig.sh)
=====================================================

## Features
 * Path to MySQL data is set to `./data/mysql` folder and can be changed in `docker-compose.yml`
 * Public port isset by default to `9001` and can be changed in `docker-compose.yml`
 * Logs are persistent and accessible from host in `./log/mysql` folder

## Commands
 * `fig up` to run both services in the foreground
 * `fig up -d` to run both services in the background
 * `fig run etherpad env` to check the internal environment variables
 
## Known issues
Run `fig up` again if first time fails! this is because mysql container takes some time to warm up the first time
