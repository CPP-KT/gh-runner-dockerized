#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

cpp_compiler=${1:?"Missing cpp compiler"}

runner_version=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | jq --raw-output '.tag_name' | tr -d v)

docker build "${SCRIPT_DIR}" \
    --pull \
    --tag "cpp-kt/gh-runner-ubuntu:${cpp_compiler}-exp" \
    --build-arg "CPP_COMPILER=${cpp_compiler}" \
    --build-arg "RUNNER_VERSION=${runner_version}"
