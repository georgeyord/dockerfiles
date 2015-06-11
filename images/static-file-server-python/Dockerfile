FROM python:3
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

WORKDIR /static
VOLUME /static

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/python", "-m", "http.server", "80"]