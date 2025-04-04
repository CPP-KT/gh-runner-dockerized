#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

RUNNER_VERSION=${1:?"Missing RUNNER_VERSION"}
CPP_COMPILER=${2:?"Missing CPP_COMPILER"}

docker build "$SCRIPT_DIR" \
    --pull \
    --tag "cpp-kt/gh-runner-ubuntu:$CPP_COMPILER-exp" \
    --build-arg "CPP_COMPILER=$CPP_COMPILER" \
    --build-arg "RUNNER_VERSION=$RUNNER_VERSION"
