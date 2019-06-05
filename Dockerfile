FROM ruby:2.5-alpine

RUN apk add --update nodejs g++ make bash

WORKDIR /usr/src/app

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install

COPY . .

VOLUME /usr/src/app

EXPOSE 4567

CMD [ "bundle", "exec", "middleman", "server", "--watcher-force-polling" ]
