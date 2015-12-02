FROM golang

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --quiet > /dev/null && \
  apt-get install --assume-yes --force-yes -qq \
  haproxy  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*
