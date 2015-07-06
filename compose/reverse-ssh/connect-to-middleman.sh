#!/bin/bash

if [ -z "$1" ]; then
    echo "First argument should the middleman-user, eg. 'user', exiting..."
    exit 1
fi

if [ -z "$2" ]; then
    echo "Second argument should the middleman's public-ip or domanin name, eg. 'mydocker.co', exiting..."
    exit 1
fi

if [ -z "$3" ]; then
    echo "Using SSH port for destination server: 22."
    $3=22
fi

ssh -R 2200:localhost:$3 $1@$2