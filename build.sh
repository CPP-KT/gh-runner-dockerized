#!/usr/bin/env bash
set -eu

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")

current_version_file="${SCRIPT_DIR}/.runner-version"
new_version=$(curl -s "https://api.github.com/repos/actions/runner/releases/latest" | jq --raw-output '.tag_name' | tr -d v)

if [[ -f "${current_version_file}" && "${new_version}" == $(cat "${current_version_file}") ]]; then
    echo "No upgrade needed."
    exit 0
fi

cpp_compilers=(gcc-14 clang-19)
cpp_compilers_for_ghc=(gcc-14)

for compiler in "${cpp_compilers[@]}"; do
    "${SCRIPT_DIR}"/base/build.sh "${new_version}" "${compiler}"
done

for compiler in "${cpp_compilers_for_ghc[@]}"; do
    "${SCRIPT_DIR}"/ghc/build.sh "${compiler}" lts-18.28
done

"${SCRIPT_DIR}"/awaiter/build.sh "${new_version}"

echo "${new_version}" > "${current_version_file}"
docker image prune -f
