# Conventions

## When

Read this when editing workspace configuration, documentation, or scripts.

## Rules / Facts

- Keep the root limited to workspace coordination; add no duplicate Bazel
  module, dependency installer, or project-specific development tooling here.
- Keep repository URLs, checkout locations, and source revisions in
  `wheelos.repos`.
- Keep external dependency versions and module extensions in
  `src/apollo-lite/MODULE.bazel`.
- When changing a checkout path or Bzlmod module name, update the manifest,
  build wrapper, README, and this architecture guide together.
- Keep `scripts/build.sh` a thin wrapper around Bazel and pass target arguments
  through unchanged.
- Checkouts under `/src/` are managed by vcstool and must remain untracked.

## Sources

- `README.md`
- `.gitignore`
- `wheelos.repos`
- `scripts/build.sh`
