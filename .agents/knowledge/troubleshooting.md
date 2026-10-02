# Troubleshooting

## When

Read this when source import or workspace builds fail.

## Rules / Facts

- If a checkout is missing, run `vcs import src < wheelos.repos` from the
  workspace root.
- If `vcs` is unavailable, install/configure vcstool in the development
  environment; this repository intentionally does not install host tools.
- If Bazel is unavailable or the version is wrong, use the version specified by
  `src/apollo-lite/.bazelversion`.
- If the build reports an unresolved WheelOS module, check that all five
  repositories are present and that the corresponding local module override in
  `scripts/build.sh` matches the module declaration in that repository's
  `MODULE.bazel`.
- Run Bazel from `src/apollo-lite` so it uses the main repository's Bzlmod
  configuration.

## Sources

- `README.md`
- `wheelos.repos`
- `scripts/build.sh`
- `src/apollo-lite/MODULE.bazel`
- `src/apollo-lite/.bazelversion`
