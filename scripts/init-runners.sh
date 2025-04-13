#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

"${SCRIPT_DIR}"/stop-runners.sh

runners=(
    gcc-14 gcc-14 gcc-14
    clang-19 clang-19 clang-19
    gcc-14-ghc
)

for runner in "${runners[@]}"; do
    "${SCRIPT_DIR}"/create-runner.sh "${runner}"
done
