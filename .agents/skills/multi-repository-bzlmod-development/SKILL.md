# Multi-repository Bzlmod development

## When

Use this workflow when adding or changing source repositories managed by
vcstool, Bzlmod modules, the local Bazel Central Registry, or the development
build configuration.

## Repository ownership

- The workspace root manages the Apollo-Lite repository through
  `wheelos.repos`; Apollo-Lite manages source checkouts under `pkgs/` through
  its own `wheelos.repos`.
- vcstool owns checkout locations and source revisions. Keep those in the
  matching manifest, not in build scripts or Bazel module declarations. Use
  moving branches for active development only; pin tags or commit IDs when a
  reproducible source snapshot is required.
- Apollo-Lite's `MODULE.bazel` declares dependency edges and versions;
  `pkgs/bazel-central-registry` supplies module metadata and source resolution
  for modules absent from configured registries.
- Bazel builds Apollo-Lite and its module graph. Keep repository-root scripts
  as thin wrappers and do not add a competing root Bazel workspace.

## Workflow

1. Import the application repository from the workspace root:

   ```bash
   vcs import src < wheelos.repos
   ```

2. Import source libraries and the local registry from Apollo-Lite:

   ```bash
   cd src/apollo-lite
   vcs import pkgs < wheelos.repos
   ```

3. Before adding a dependency, inspect its `MODULE.bazel` module name and
   `src/apollo-lite/MODULE.bazel` dependency declaration. Check the configured
   registries for the required module and version.
4. If the module/version is missing from the configured registries, add a
   complete registry entry under
   `pkgs/bazel-central-registry/modules/<module>/<version>/`, including its
   `MODULE.bazel`, source metadata, version metadata, and any required patches.
   A registry entry makes a module resolvable; the consuming root module still
   needs the appropriate `bazel_dep`.
5. For a module already resolvable from a registry, add or retain
   `--override_module=<module-name>=%workspace%/pkgs/<checkout>` in
   `.bazelrc.dev` to compile against the local vcstool checkout. The override
   name must exactly match that checkout's `MODULE.bazel`.
6. Build with the development configuration:

   ```bash
   ./scripts/build.sh --config=dev <target>
   ```

   `.bazelrc.dev` uses `%workspace%`-relative paths and expects Bazel to run
   from the Apollo-Lite workspace.

## Validation

- Run `vcs validate < wheelos.repos` at both the workspace root and
  `src/apollo-lite`.
- Confirm every imported checkout path/name matches its manifest entry and
  every `--override_module` name matches the checkout's `MODULE.bazel`.
- Confirm local registry entries cover modules/versions that are not available
  from the configured remote registries.
- Run `bash -n scripts/build.sh`, `git diff --check`, and a focused Bazel build
  with `--config=dev`.
- Keep `pkgs/` source checkouts untracked and preserve user-specific
  `.bazelrc.user` changes.
