#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

CPP_COMPILER=${1:?"Missing CPP_COMPILER"}
STACK_RESOLVER=${2:?"Missing STACK_RESOLVER"}

docker build "$SCRIPT_DIR" \
    --tag "cpp-kt/gh-runner-ubuntu:$CPP_COMPILER-ghc" \
    --build-arg "CPP_COMPILER=$CPP_COMPILER" \
    --build-arg "STACK_RESOLVER=$STACK_RESOLVER"
