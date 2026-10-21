# Roadmap

## In progress
- Provider compatibility matrix: verify the deployment end-to-end on
  additional ARM64 cloud instance types and record kernel/binder results
  per provider in the docs.
- ShellCheck in CI for every change to the deployment script.

## Planned
- Optional full-GApps build profile (complete Google app set instead of
  the minimal package) as a config flag.
- QingFeng OS customization layer: system name/branding, boot animation
  and default app set applied on top of the stock redroid base.
- Release checklist with a security pass over container flags, pulled
  images and default ports before each tagged release.

## Not planned
- Exposing ADB or casting ports to the public internet. Access stays
  tunnel-only by design.
