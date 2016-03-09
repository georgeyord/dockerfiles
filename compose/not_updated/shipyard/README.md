[Shipyard](https://github.com/shipyard/shipyard) manager and agent in Docker containers using docker-compose
=====================================================

## Quick Start
 * Run `docker-compose up` to start both the manager and the agent
 * Log in the WebUI [localhost:8845](http://localhost:8845) Username: `admin` Password: `shipyard`
 * In the WebUI, go to `Hosts`, approve the new agent and copy the new key
 * Add the key in `docker-compose.yml`
 * Re-run both manager and agent using `docker-compose up -d` again

## Features
 * Shipyard manager runs on port `8800` by default and can be changed in `docker-compose.yml`
 * Shipyard agent runs on port `8845` by default and can be changed in `docker-compose.yml`

## Commands
 * `docker-compose up` to run both agent in the foreground and manager in the background
 * `docker-compose up -d` to run both services in the background
 * `docker-compose run agent env` to check the internal agent's environment variables
 * `docker-compose run manager env` to check the internal manager's environment variables