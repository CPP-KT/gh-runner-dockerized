#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

runner_version=${1:?"Missing runner version"}

docker build "${SCRIPT_DIR}" \
    --pull \
    --tag "cpp-kt/gh-runner-ubuntu:awaiter" \
    --build-arg "RUNNER_VERSION=${runner_version}"
