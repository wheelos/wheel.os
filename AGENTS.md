# Agent Guide

## Rules

- Read the relevant workspace files before changing repository or build behavior.
- Keep this repository focused on coordinating source checkouts and builds.
- Use vcstool for source repositories, Bzlmod for dependencies, and Bazel for builds.
- Keep Bazel module and dependency definitions in `src/apollo-lite`; do not add a
  competing root `MODULE.bazel` or `WORKSPACE`.
- Preserve the repository-to-module mapping documented in
  `.agents/knowledge/architecture.md`.
- Make narrow changes and preserve unrelated user changes.
- Read `.agents/skills/workspace-validation/SKILL.md` before validating workspace
  or build changes.
- Read `.agents/skills/review/SKILL.md` before reviewing changes.

## Commands

- Import Apollo-Lite: `vcs import src < wheelos.repos`
- Import its source libraries: `cd src/apollo-lite && vcs import pkgs < wheelos.repos`
- Check checkout status: `vcs status src`
- Build the default Apollo-Lite install target: `./scripts/build.sh`
- Build a specific target: `./scripts/build.sh @core//cyber/...`
- Build against local source checkouts: `./scripts/build.sh --config=dev @core//cyber/...`
- Check the build wrapper syntax: `bash -n scripts/build.sh`

## Knowledge

- Workspace layout and module mapping: `.agents/knowledge/architecture.md`
- Repository and configuration conventions: `.agents/knowledge/conventions.md`
- Checkout and build troubleshooting: `.agents/knowledge/troubleshooting.md`

## Skills

- Workspace/build validation: `.agents/skills/workspace-validation/SKILL.md`
- Change review: `.agents/skills/review/SKILL.md`
- Multi-repository Bzlmod development: `.agents/skills/multi-repository-bzlmod-development/SKILL.md`
