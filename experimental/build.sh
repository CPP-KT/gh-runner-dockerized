#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

CPP_COMPILER=${1:?"Missing CPP_COMPILER"}

VERSION=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | jq --raw-output '.tag_name' | tr -d v)

docker build "$SCRIPT_DIR" \
    --pull \
    --tag "cpp-kt/gh-runner-ubuntu:${CPP_COMPILER}-exp" \
    --build-arg "CPP_COMPILER=${CPP_COMPILER}" \
    --build-arg "RUNNER_VERSION=${VERSION}"
