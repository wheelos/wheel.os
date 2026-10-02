# Architecture

## When

Read this when changing the workspace manifest, repository layout, or build
wrapper.

## Rules / Facts

- The workspace root coordinates repositories; it is not a Bazel workspace.
- `wheelos.repos` checks out source repositories under `src/`:

  | Repository | Checkout path | Role |
  | --- | --- | --- |
  | `wheelos/apollo-lite` | `src/apollo-lite` | Main project and Bazel root |
  | `wheelos/core` | `src/core` | Middleware |
  | `wheelos/wheelos_msgs` | `src/wheelos_msgs` | Message interfaces |
  | `wheelos/common` | `src/common` | Common libraries |
  | `wheelos/map` | `src/map` | Map libraries |

- `src/apollo-lite/MODULE.bazel` owns Bzlmod dependencies and
  `src/apollo-lite/.bazelversion` selects the Bazel version.
- `scripts/build.sh` runs Bazel from `src/apollo-lite` and locally overrides
  these Bzlmod module names with workspace checkouts:

  | Bzlmod module | Local checkout |
  | --- | --- |
  | `wheelos_core` | `src/core` |
  | `wheelos_msgs` | `src/wheelos_msgs` |
  | `wheelos_common` | `src/common` |
  | `wheelos_map` | `src/map` |

- Source revision selection belongs in `wheelos.repos`; dependency version
  selection belongs in the main repository's Bzlmod configuration.

## Sources

- `README.md`
- `wheelos.repos`
- `scripts/build.sh`
