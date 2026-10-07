# WheelOS workspace

This repository coordinates the Apollo-Lite checkout. Apollo-Lite manages its
source libraries with vcstool, Bzlmod manages build dependencies, and Bazel
builds inside `apollo-lite`. No Bazel module is defined in this root repository.

| Repository | Workspace Path | Role |
| --- | --- | --- |
| [apollo-lite](https://github.com/wheelos/apollo-lite) | `src/apollo-lite` | Main repository |
| [core](https://github.com/wheelos/core) | `src/apollo-lite/pkgs/core` | Middleware |
| [wheelos_msgs](https://github.com/wheelos/wheelos_msgs) | `src/apollo-lite/pkgs/wheelos_msgs` | Message interfaces |
| [common](https://github.com/wheelos/common) | `src/apollo-lite/pkgs/common` | Common library |
| [map](https://github.com/wheelos/map) | `src/apollo-lite/pkgs/map` | Map library |
| [bazel-central-registry](https://github.com/wheelos/bazel-central-registry) | `src/apollo-lite/pkgs/bazel-central-registry` | Development module registry |

## Getting the Source Code

After installing and configuring `vcstool`, import Apollo-Lite from this
repository root:

```bash
vcs import src < wheelos.repos
```

Then import its source-library checkouts from `src/apollo-lite`:

```bash
cd src/apollo-lite
vcs import pkgs < wheelos.repos
```

Update the main repository and its library checkouts separately with
`vcs pull src` and `cd src/apollo-lite && vcs pull pkgs`. Their revisions are
selected by their respective manifests. External dependency versions and the
Bazel version are managed by `src/apollo-lite/MODULE.bazel` and `.bazelversion`.

## Building

After importing the source code, run the script to build the main repository's install target by default:

```bash
./scripts/build.sh
```

You can also pass a Bazel target as an argument, for example:

```bash
./scripts/build.sh @core//cyber/...
```

The build script invokes Bazel from `src/apollo-lite`. Its `.bazelrc.user`
contains per-user settings. To build against the vcstool-managed source
checkouts and local module registry, enable the development config:

```bash
./scripts/build.sh --config=dev @core//cyber/...
```

The `.bazelrc.dev` development config uses `pkgs/bazel-central-registry` and
overrides published WheelOS modules with local checkouts relative to the
Apollo-Lite workspace. The development registry supplies module metadata and
source entries; Bzlmod still resolves and builds the dependency graph, while
vcstool owns source checkout revisions.