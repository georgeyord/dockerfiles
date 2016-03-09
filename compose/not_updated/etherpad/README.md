Etherpad with MySql persistency in Docker container using docker-compose
=====================================================

## Features
 * Path to MySQL data is set to `./data/mysql` folder and can be changed in `docker-compose.yml`
 * Public port isset by default to `9001` and can be changed in `docker-compose.yml`
 * Logs are persistent and accessible from host in `./log/mysql` folder

## Commands
 * `docker-compose up` to run both services in the foreground
 * `docker-compose up -d` to run both services in the background
 * `docker-compose run etherpad env` to check the internal environment variables
 
## Known issues
Run `docker-compose up` again if first time fails! this is because mysql container takes some time to warm up the first time
