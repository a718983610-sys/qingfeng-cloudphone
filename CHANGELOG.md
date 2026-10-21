# Changelog

All notable changes to this project are documented here.
Format follows [Keep a Changelog](https://keepachangelog.com/), versions
follow [Semantic Versioning](https://semver.org/).

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
