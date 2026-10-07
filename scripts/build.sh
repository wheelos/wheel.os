#!/usr/bin/env bash
set -euo pipefail

workspace_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
apollo_root="${workspace_root}/src/apollo-lite"

if [[ ! -d "${apollo_root}" ]]; then
  printf 'Missing repository: src/apollo-lite\n' >&2
  printf 'Import it with: vcs import src < wheelos.repos\n' >&2
  exit 1
fi

for repository in core wheelos_msgs common map; do
  if [[ ! -d "${apollo_root}/pkgs/${repository}" ]]; then
    printf 'Missing dependency checkout: src/apollo-lite/pkgs/%s\n' "${repository}" >&2
    printf 'Import dependencies with: cd src/apollo-lite && vcs import pkgs < wheelos.repos\n' >&2
    exit 1
  fi
done

if ! command -v bazel >/dev/null 2>&1; then
  printf 'Bazel is not installed or not on PATH.\n' >&2
  exit 1
fi

targets=("$@")
if [[ "${#targets[@]}" -eq 0 ]]; then
  targets=("//:install")
fi

cd "${apollo_root}"
exec bazel build "${targets[@]}"
