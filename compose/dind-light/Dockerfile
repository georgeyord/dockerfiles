FROM debian:stable

ENV DEBIAN_FRONTEND noninteractive

# Set Docker ip as environmental variable to use it easily
ENV DOCKER_IP 172.17.42.1

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update --quiet > /dev/null && \
  apt-get dist-upgrade --assume-yes --force-yes -qq && \
  apt-get install --assume-yes --force-yes -qq && \
  apt-get autoremove

# Install apt-utils before the rest to avoid delayed configuration and other problems
RUN apt-get update --quiet > /dev/null && \
    apt-get install --assume-yes --force-yes -qq \
    sudo apt-utils apt-transport-https net-tools adduser procps \
    htop make gcc \
    python-setuptools python-software-properties \
    byobu vim wget curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install docker + docker-compose
RUN apt-get update --quiet > /dev/null && \
    apt-get install --assume-yes --force-yes -qq \
    lxc-docker && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Link in shared parts of the home directory
RUN ln -s /var/shared/.ssh && \
    ln -s /var/shared/.bash_aliases

VOLUME /var/shared
WORKDIR /var/shared