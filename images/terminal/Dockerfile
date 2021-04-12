FROM debian:latest

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV DEBIAN_FRONTEND noninteractive

ENV GOTTY_VERSION="1.0.1"
ENV ZSH_IN_DOCKER_VERSION="1.1.1"

ADD files/setup-zsh.sh /setup-zsh.sh
RUN chmod +x /setup-zsh.sh
RUN apt-get update --quiet > /dev/null \
    && apt-get install --assume-yes -qq \
      apt-transport-https \
      ca-certificates \
      curl \
      byobu \
      curl \
      git \
      gnupg \
      gosu \
      libssl-dev \
      lsb-release \
      netcat \
      net-tools \
      ssh-client \
      software-properties-common \
      sudo \
      wget \
    \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update --quiet > /dev/null \
    && apt-get install --assume-yes docker-ce \
    && curl -sLk https://github.com/yudai/gotty/releases/download/v${GOTTY_VERSION}/gotty_linux_amd64.tar.gz \
      | tar xzC /usr/local/bin \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && /setup-zsh.sh

SHELL ["/bin/zsh", "-c"]
EXPOSE 8080

ADD files/.gotty /.gotty
ADD files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/bin/zsh"]
