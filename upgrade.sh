#!/bin/bash

SCRIPT_DIR=$(cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

CURRENT_VERSION=$(cat $SCRIPT_DIR/.runner-version)
NEW_VERSION=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | jq --raw-output '.tag_name' | tr -d v)

COMPILERS=( gcc-14 clang-19 )

if [[ "$NEW_VERSION" != "$CURRENT_VERSION" ]]; then
    for compiler in "${COMPILERS[@]}"; do
        full_version="$NEW_VERSION-${compiler}"
        docker build -t cpp-kt/gh-runner-ubuntu:$full_version --build-arg "COMPILER=$compiler" --build-arg VERSION=$NEW_VERSION $SCRIPT_DIR
    done

    echo $NEW_VERSION > $SCRIPT_DIR/.runner-version
else
    echo "No upgrade needed."
fi
