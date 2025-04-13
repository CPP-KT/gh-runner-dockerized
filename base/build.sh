#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

runner_version=${1:?"Missing runner version"}
cpp_compiler=${2:?"Missing cpp compiler"}

docker build "${SCRIPT_DIR}" \
    --pull \
    --tag "cpp-kt/gh-runner-ubuntu:${cpp_compiler}" \
    --build-arg "CPP_COMPILER=${cpp_compiler}" \
    --build-arg "RUNNER_VERSION=${runner_version}"
