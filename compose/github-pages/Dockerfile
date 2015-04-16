FROM ruby

MAINTAINER George Papaefhimiou <george.yord+docker@gmail.com>

RUN gem install --no-document \
        github-pages:20 \
        therubyracer

VOLUME ['/usr/app/src']
WORKDIR /usr/app/src

EXPOSE 4000
CMD jekyll serve --watch --drafts --baseurl ''