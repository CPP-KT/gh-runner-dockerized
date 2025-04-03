#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

CPP_COMPILER=${1:?"Missing CPP_COMPILER"}

docker build "$SCRIPT_DIR" \
    --pull \
    --tag "cpp-kt/gh-runner-ubuntu:${CPP_COMPILER}-exp" \
    --build-arg "CPP_COMPILER=${CPP_COMPILER}" 
