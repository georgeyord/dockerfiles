FROM node
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

RUN npm install -g node-static
WORKDIR /static
VOLUME /static

EXPOSE 8080

ENTRYPOINT static --host-address 0.0.0.0 --gzip