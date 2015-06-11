FROM node
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

RUN npm install -g node-static
WORKDIR /static
VOLUME /static

EXPOSE 80

ENTRYPOINT ["static", "-p", "80"]