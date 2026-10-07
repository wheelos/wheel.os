# Architecture

## When

Read this when changing the workspace manifest, repository layout, or build
wrapper.

## Rules / Facts

- The workspace root coordinates repositories; it is not a Bazel workspace.
- The root `wheelos.repos` checks out only Apollo-Lite under `src/`; the
  nested `src/apollo-lite/wheelos.repos` manages its source libraries under
  `src/apollo-lite/pkgs/`:

  | Repository | Checkout path | Role |
  | --- | --- | --- |
  | `wheelos/apollo-lite` | `src/apollo-lite` | Main project and Bazel root |
  | `wheelos/core` | `src/apollo-lite/pkgs/core` | Middleware |
  | `wheelos/wheelos_msgs` | `src/apollo-lite/pkgs/wheelos_msgs` | Message interfaces |
  | `wheelos/common` | `src/apollo-lite/pkgs/common` | Common libraries |
  | `wheelos/map` | `src/apollo-lite/pkgs/map` | Map libraries |

- `src/apollo-lite/MODULE.bazel` owns Bzlmod dependencies and
  `src/apollo-lite/.bazelversion` selects the Bazel version.
- `scripts/build.sh` runs Bazel from `src/apollo-lite`; its `.bazelrc.user`
  contains user settings. `--config=dev` activates `.bazelrc.dev`, which
  locally overrides these Bzlmod module names with the `pkgs/` checkouts:

  | Bzlmod module | Local checkout |
  | --- | --- |
  | `wheelos_core` | `src/apollo-lite/pkgs/core` |
  | `wheelos_msgs` | `src/apollo-lite/pkgs/wheelos_msgs` |
  | `wheelos_common` | `src/apollo-lite/pkgs/common` |
  | `wheelos_map` | `src/apollo-lite/pkgs/map` |

- `src/apollo-lite/pkgs/bazel-central-registry` is the development Bzlmod
  registry. Add missing WheelOS module metadata there; use local module
  overrides to compile from the vcstool-managed checkout.

- The development container mounts Apollo-Lite once at `/apollo`.
  `.bazelrc.dev` uses workspace-relative `pkgs/` paths for the local registry
  and module checkouts; do not maintain copies under `external/`.
- Source revision selection belongs in the matching `wheelos.repos` manifest;
  dependency version selection belongs in `src/apollo-lite/MODULE.bazel`.
- Development builds use `./scripts/build.sh --config=dev <target>`; the
  development config resolves the registry and source checkouts relative to the
  Apollo-Lite workspace.

## Sources

- `README.md`
- `wheelos.repos`
- `scripts/build.sh`
