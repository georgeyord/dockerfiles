FROM debian:latest

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV DEBIAN_FRONTEND noninteractive

ENV DOCKER_COMPOSE_VERSION="1.28.5"
ENV GOTTY_VERSION="1.0.1"
ENV GOTTY_OPTIONS=""
ENV PATH="$PATH:/usr/local/gcloud/google-cloud-sdk/bin"
RUN apt-get update --quiet > /dev/null \
    && apt-get install --assume-yes -qq \
      awscli \
      apt-transport-https \
      ca-certificates \
      curl \
      build-essential \
      byobu \
      curl \
      fonts-firacode \
      git \
      gcc \
      gnupg \
      gosu \
      libssl-dev \
      locales \
      locales-all \
      lsb-release \
      netcat \
      net-tools \
      procps \
      ssh-client \
      software-properties-common \
      sudo \
      wget \
      vim \
      zsh \
    \
    #
    # docker
    # teraform
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - \
    && apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update --quiet > /dev/null \
    && apt-get install --assume-yes docker-ce \
    #
    # GoTTY
    && curl -sLk https://github.com/yudai/gotty/releases/download/v${GOTTY_VERSION}/gotty_linux_amd64.tar.gz \
      | tar xzC /usr/local/bin \
    #
    # docker-compose
    && curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose \
    && locale-gen en_US.UTF-8 \
    #
    # Gcloud cli
    && curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz \
    && mkdir -p /usr/local/gcloud \
    && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
    && /usr/local/gcloud/google-cloud-sdk/install.sh\
    && gcloud version \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

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

ENV SUDO_WITHOUT_PASSWORD="true"

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/usr/bin/byobu"]
