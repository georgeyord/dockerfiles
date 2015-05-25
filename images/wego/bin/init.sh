#!/bin/bash

if [[ -z "$API_KEY" ]]; then
    echo "An API_KEY is required, go to https://developer.worldweatheronline.com/auth/register to get one. Then add the option '-e API_KEY=[API KEY]' to your docker run command"
    exit 1;
fi

sed -i "s/\"APIKey\": \"\",/\"APIKey\": \"$API_KEY\",/g" /root/.wegorc

wego $*