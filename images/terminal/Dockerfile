FROM debian:latest

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV DEBIAN_FRONTEND noninteractive

ENV DOCKER_COMPOSE_VERSION="1.28.5"
ENV GOTTY_VERSION="1.0.1"
ENV GOTTY_OPTIONS=""
RUN apt-get update --quiet > /dev/null \
    && apt-get install --assume-yes -qq \
      apt-transport-https \
      ca-certificates \
      curl \
      byobu \
      curl \
      fonts-firacode \
      git \
      gnupg \
      gosu \
      libssl-dev \
      locales \
      locales-all \
      lsb-release \
      netcat \
      net-tools \
      ssh-client \
      software-properties-common \
      sudo \
      wget \
      zsh \
    \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update --quiet > /dev/null \
    && apt-get install --assume-yes docker-ce \
    && curl -sLk https://github.com/yudai/gotty/releases/download/v${GOTTY_VERSION}/gotty_linux_amd64.tar.gz \
      | tar xzC /usr/local/bin \
    && curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && locale-gen en_US.UTF-8 \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

ENV ZSH_IN_DOCKER_VERSION="1.1.1"
ADD ./files/zsh-in-docker.sh /zsh-in-docker.sh
ADD ./files/setup-zsh.sh /setup-zsh.sh
RUN chmod +x /*.sh \
    && /setup-zsh.sh

ENV LANG='en_US.UTF-8'
ENV LANGUAGE='en_US:en'
ENV LC_ALL='en_US.UTF-8'
ENV TERM="xterm"

ENV SHELL="/bin/zsh"
SHELL ["/bin/zsh", "-c"]
EXPOSE 8080

ADD ./files/.gotty /.gotty
ADD ./files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/usr/bin/byobu"]
