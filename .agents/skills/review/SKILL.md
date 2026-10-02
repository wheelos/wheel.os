---
name: review
description: Review changes to the workspace manifest, build wrapper, and workspace documentation. Use when reviewing or preparing changes for submission.
---

# Review

## When

Read this when reviewing workspace configuration or preparing a change for
submission.

## Rules / Facts

- Inspect the complete diff and preserve unrelated pre-existing changes.
- Verify that repository URLs, checkout paths, Bzlmod module names, and local
  overrides agree across the manifest, wrapper, and documentation.
- Confirm this repository remains an orchestration workspace and does not
  acquire duplicate dependency or build configuration.
- Report only reproducible issues, with file and line references.

## Sources

- `AGENTS.md`
- `.agents/knowledge/architecture.md`
- `.agents/knowledge/conventions.md`
- `README.md`
- `wheelos.repos`
- `scripts/build.sh`
