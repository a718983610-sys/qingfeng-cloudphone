# Roadmap

## Done
- v0.1.0 initial release (2026-10-21).
- ShellCheck in CI for every change to the deployment script.
- Issue templates (bug report, compatibility question, provider report).
- Security policy (`SECURITY.md`).

## In progress
- Provider compatibility matrix: verify the deployment end-to-end on
  additional ARM64 cloud instance types and record kernel/binder results
  per provider in `docs/providers.md`.

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
