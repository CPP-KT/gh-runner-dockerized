#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

CURRENT_VERSION_FILE="$SCRIPT_DIR/.runner-version"
NEW_VERSION=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | jq --raw-output '.tag_name' | tr -d v)

if [[ -f "$CURRENT_VERSION_FILE" && "$NEW_VERSION" == $(cat "$CURRENT_VERSION_FILE") ]]; then
    echo "No upgrade needed."
    exit 0
fi

ALL_COMPILERS=(gcc-14 clang-19)

for compiler in "${ALL_COMPILERS[@]}"; do
    "$SCRIPT_DIR"/base/build.sh "$NEW_VERSION" "$compiler"
done

for compiler in "${ALL_COMPILERS[@]}"; do
    "$SCRIPT_DIR"/ghc/build.sh "$compiler" lts-18.28
done

echo "$NEW_VERSION" > "$CURRENT_VERSION_FILE"
