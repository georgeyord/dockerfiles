#!/bin/bash

ENV_PATH="`pwd`"
COMPOSE_PATH="${ENV_PATH}/../../compose"

COMPOSE_BUNDLE_INDEX=0

# Start service discovery
COMPOSE_BUNDLE[$COMPOSE_BUNDLE_INDEX]="sd-registrator-discover"
COMPOSE_BUNDLE_INDEX=$COMPOSE_BUNDLE_INDEX+1

for FOLDER in "${COMPOSE_BUNDLE[@]}"; do
    echo "Run docker-compose in '${COMPOSE_PATH}/${FOLDER}'"
    cd "${COMPOSE_PATH}/${FOLDER}"

    if [ ! -f docker-compose.yml ]; then
        if [ ! -f docker-compose.example.yml ]; then
            echo "Both docker-compose.example.yml and docker-compose.yml are missing..."
            exit 1
        fi
        echo "Copying docker-compose.yml from docker-compose.example.yml..."
        cp docker-compose.example.yml docker-compose.yml
    fi

#    docker-compose kill && \
#    docker-compose rm -f && \
    docker-compose up -d && \
    docker-compose ps && \
    echo "Bundle ${FOLDER} started..." && \
    sleep 2
done

cd $ENV_PATH; docker-compose up $*
