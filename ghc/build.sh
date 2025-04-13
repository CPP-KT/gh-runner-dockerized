#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

cpp_compiler=${1:?"Missing cpp compiler"}
stack_resolver=${2:?"Missing stack resolver"}

docker build "${SCRIPT_DIR}" \
    --tag "cpp-kt/gh-runner-ubuntu:${cpp_compiler}-ghc" \
    --build-arg "CPP_COMPILER=${cpp_compiler}" \
    --build-arg "STACK_RESOLVER=${stack_resolver}"
