FROM nginx

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qqy update && \
    apt-get -qqy install gettext-base && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ENV PUBLIC_PORT=80
ENV TARGET_HOST=target
ENV TARGET_PORT=8080

# Default credentials: user:qwerty1
ADD bin/htpasswd /etc/nginx/conf.d/htpasswd
ADD bin/nginx.conf.tpl /etc/nginx/conf.d/default.conf.tpl

ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

CMD ["/init.sh"]
