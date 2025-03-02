#!/bin/bash

name=${1:?}

while true; do
  echo "Starting Docker"
  if [[ -f .kill-docker ]]; then
    echo "WARNING!"
    echo "Kill-switch detected, Docker won't be restarted"
  fi

  docker run --runtime sysbox-runc --name=$name --rm --env-file=.env ct-itmo/gh-runner-ubuntu:$(cat runner-version)
  if [[ -f .kill-docker ]]; then
    echo "Kill-switch detected, exiting"
    break
  fi
done
