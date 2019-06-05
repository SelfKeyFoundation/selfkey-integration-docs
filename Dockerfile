FROM ruby:2.5-alpine

RUN apk add --update nodejs g++ make bash

COPY . /usr/src/app

VOLUME /usr/src/app

WORKDIR /usr/src/app

RUN bundle install

EXPOSE 4567

CMD [ "bundle", "exec", "middleman", "server", "--watcher-force-polling" ]
