PhpMyAdmin WebUI for MySQL servers
==================================

## Quick Start
 * `cp -n docker-compose.yml.example docker-compose.yml` to initialize your local configuration file
 * Edit docker-compose.yml and add the mysql container name to `[mysql container]` placeholder 
 * `docker-compose up -d` to run mysql server in the background
 * Go to [localhost:13306](http://localhost:13306) to connect to your DB