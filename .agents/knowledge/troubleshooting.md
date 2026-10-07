# Troubleshooting

## When

Read this when source import or workspace builds fail.

## Rules / Facts

- If Apollo-Lite is missing, run `vcs import src < wheelos.repos` from the
  workspace root. If a library checkout is missing, run
  `cd src/apollo-lite && vcs import pkgs < wheelos.repos`.
- If `vcs` is unavailable, install/configure vcstool in the development
  environment; this repository intentionally does not install host tools.
- If Bazel is unavailable or the version is wrong, use the version specified by
  `src/apollo-lite/.bazelversion`.
- For source-library builds, import the nested manifest with
  `cd src/apollo-lite && vcs import pkgs < wheelos.repos`, then pass
  `--config=dev` to Bazel or `scripts/build.sh`.
- If Bzlmod cannot find a WheelOS module, check
  `src/apollo-lite/pkgs/bazel-central-registry` for its module/version entry.
  Add missing registry metadata there; for local development, ensure the
  module name in `.bazelrc.dev`'s `--override_module` matches the checkout's
  `MODULE.bazel`.
- `.bazelrc.dev` uses `%workspace%`-relative registry and checkout paths; run
  Bazel from the Apollo-Lite workspace so these resolve to its `pkgs/`
  directory.
- Run Bazel from `src/apollo-lite` so it uses the main repository's Bzlmod
  configuration.

## Sources

- `README.md`
- `wheelos.repos`
- `scripts/build.sh`
- `src/apollo-lite/MODULE.bazel`
- `src/apollo-lite/.bazelversion`
