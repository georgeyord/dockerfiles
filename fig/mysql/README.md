MySQL Server/Client in Docker container using [Fig](http://www.fig.sh)
=====================================================

## Quick Start
 * `fig up -d` to run mysql server in the background
 * `fig run mysql sh -c 'exec mysql -h"mysql_mysql_1" -P"3306" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"'` to connect to the running server

## Features
 * MySQL port used by default is `3306` and can be changed in `fig.yml`
 * MySQL data are persistent in `./data` folder
 * MySQL logs are persistent and accessible from host in `./log` folder
 * Default root user is `root` with default password `qwerty1`
 * Use Docker environment variable `MYSQL_ROOT_PASSWORD` to set the desired password for `root`
 * Use Docker environment variable `MYSQL_DATABASE` to ensure a database exists with this name
 * Use Docker environment variable `MYSQL_USER` and `MYSQL_PASSWORD` to ensure a user exists with this name and password

## Commands
 * `fig up` to run mysql server in the foreground
 * `fig up -d` to run mysql server in the background
 * `fig run mysql env` to check the internal environment variables
 * `fig run mysql sh -c 'exec mysql -h"mysql_mysql_1" -P"$MYSQL_PORT_3306_TCP_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD"'` to run mysql client and connect to the running server