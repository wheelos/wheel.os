# WheelOS workspace

This repository is solely responsible for organizing multi-repository source code: **vcstool manages source repositories, Bzlmod manages dependencies, and Bazel builds inside `apollo-lite`. No Bazel module is defined in the root directory; dependencies and the Bazel version are managed by `MODULE.bazel` and `.bazelversion` in the main repository.

| Repository | Workspace Path | Role |
| --- | --- | --- |
| [apollo-lite](https://github.com/wheelos/apollo-lite) | `src/apollo-lite` | Main repository |
| [core](https://github.com/wheelos/core) | `src/core` | Middleware |
| [wheelos_msgs](https://github.com/wheelos/wheelos_msgs) | `src/wheelos_msgs` | Message interfaces |
| [common](https://github.com/wheelos/common) | `src/common` | Common library |
| [map](https://github.com/wheelos/map) | `src/map` | Map library |

## Getting the Source Code

After installing and configuring `vcstool`, import the manifest from the root directory of this repository:

```bash
vcs import src < wheelos.repos
```

Update all checked-out repositories:

```bash
vcs pull src
```

Branches of the source repositories are managed by `wheelos.repos`, while external dependency versions are managed by the Bzlmod configuration in the main repository. In addition to vcstool, you need to pre-install the Bazel version specified by `.bazelversion` in the main repository.

## Building

After importing the source code, run the script to build the main repository's install target by default:

```bash
./scripts/build.sh
```

You can also pass a Bazel target as an argument, for example:

```bash
./scripts/build.sh @core//cyber/...
```

The build script invokes Bazel from `src/apollo-lite` and overrides the other four local repositories as Bzlmod modules, ensuring that local source code changes are included in the build.