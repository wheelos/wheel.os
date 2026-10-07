# Conventions

## When

Read this when editing workspace configuration, documentation, or scripts.

## Rules / Facts

- Keep the root limited to workspace coordination; add no duplicate Bazel
  module, dependency installer, or project-specific development tooling here.
- Keep repository URLs, checkout locations, and source revisions in the
  appropriate `wheelos.repos`: root for Apollo-Lite, nested for its source
  libraries.
- Use vcstool to manage source checkouts under `pkgs/`; use Bzlmod and Bazel
  to resolve and build dependencies. If a dependency module is missing from the
  configured registry, add its registry metadata to the local
  `pkgs/bazel-central-registry` before using a local module override.
- Keep external dependency versions and module extensions in
  `src/apollo-lite/MODULE.bazel`; use `src/apollo-lite/pkgs` as the sole source
  checkout location for WheelOS libraries.
- Enable local source overrides with `--config=dev`; keep user-specific options
  in `.bazelrc.user` and shared development registry/override settings in
  `.bazelrc.dev`.
- When changing a checkout path or Bzlmod module name, update the manifest,
  build wrapper, README, and this architecture guide together.
- Keep `scripts/build.sh` a thin wrapper around Bazel and pass target arguments
  through unchanged.
- Checkouts under `/src/` and `/src/apollo-lite/pkgs/` are managed by vcstool
  and must remain untracked.

## Sources

- `README.md`
- `.gitignore`
- `wheelos.repos`
- `scripts/build.sh`
