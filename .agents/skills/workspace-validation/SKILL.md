---
name: workspace-validation
description: Validate vcstool workspace configuration and the Bazel build wrapper. Use when changing the repository manifest, workspace paths, module overrides, or build entrypoint.
---

# Workspace validation

## When

Read this when changing `wheelos.repos`, repository paths, Bzlmod module
overrides, or `scripts/build.sh`.

## Rules / Facts

- Validate that `wheelos.repos` parses and contains the intended repositories,
  URLs, and revisions. Use `vcs validate < wheelos.repos` when vcstool is
  available.
- Check that every module override in `scripts/build.sh` uses the module name
  declared by the matching checkout's `MODULE.bazel`.
- Run `bash -n scripts/build.sh` and `git diff --check`.
- If source checkouts and the required Bazel version are available, run the
  smallest Bazel target covering the change from `src/apollo-lite`; otherwise
  state the environmental blocker without implying the build passed.
- Do not install dependencies or alter the user environment merely to run
  validation.

## Sources

- `wheelos.repos`
- `scripts/build.sh`
- `README.md`
