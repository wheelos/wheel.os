#!/usr/bin/env bash
set -euo pipefail

workspace_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
apollo_root="${workspace_root}/src/apollo-lite"

for repository in apollo-lite core wheelos_msgs common map; do
  if [[ ! -d "${workspace_root}/src/${repository}" ]]; then
    printf 'Missing repository: src/%s\nImport sources with: vcs import src < wheelos.repos\n' \
      "${repository}" >&2
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
exec bazel build \
  "--override_module=wheelos_core=${workspace_root}/src/core" \
  "--override_module=wheelos_msgs=${workspace_root}/src/wheelos_msgs" \
  "--override_module=wheelos_common=${workspace_root}/src/common" \
  "--override_module=wheelos_map=${workspace_root}/src/map" \
  "${targets[@]}"
