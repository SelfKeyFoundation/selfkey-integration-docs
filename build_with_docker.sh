#!/usr/bin/env bash

image=selfkey/integration-docs

image_exists=$(docker image inspect $image > /dev/null 2>&1)

if [[ ! $image_exists ]]; then
  docker build -t $image .
fi

docker run \
    --rm \
    -v $PWD/source:/usr/src/app/source \
    -w /usr/src/app/source \
    -v $PWD/build:/usr/src/app/build \
    $image bundle exec middleman build --clean
