# Changelog

All notable changes to this project are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/), versions
follow [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.1] - 2026-10-22

Maintenance release: documentation and community files only; the
deployment script is unchanged from 0.1.0.

### Added
- `SECURITY.md` with a private vulnerability reporting policy.
  *Why: the script runs privileged containers, so reporters need a
  private channel and a stated response time (acknowledgement within
  7 days).*
- Provider compatibility matrix (`docs/providers.md`) plus a matching
  issue template for structured compatibility reports.
  *Why: "does it run on provider X?" is the first question for this
  kind of tool; dated results with the exact region/instance/kernel
  are worth more than a bare "it works".*
- Honest project-status note in the README: the toolkit is ready to
  run; end-to-end deployments are still being verified across
  providers.
  *Why: the deploying cloud phone is still being brought up, and the
  README should not read as if it were already in production.*

### Changed
- Roadmap: ShellCheck CI is live (moved from "in progress" to done);
  planned items now carry rough priorities so they do not read as
  commitments in progress.

## [0.1.0] - 2026-10-21

### Added
- One-script deployment of redroid (Android 13) with Google services (GMS)
  on ARM64 Ubuntu 24.04 cloud instances, via Docker.
- `config.example.env` for Android version, screen geometry, device model,
  data directory and ADB bind address.
- Binder kernel module check that stops with a diagnosis instead of
  failing silently on unsupported cloud kernels.
- Localhost-only ADB and scrcpy-web, with SSH tunnel / Tailscale access
  guidance and security notes.
- One-directory migration between cloud providers (`docs/migration.md`).
- Troubleshooting guide covering binder, GMS builds and Play Integrity
  limitations (`docs/troubleshooting.md`).
