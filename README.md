# qingfeng-cloudphone

[![shellcheck](https://github.com/a718983610-sys/qingfeng-cloudphone/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/a718983610-sys/qingfeng-cloudphone/actions/workflows/shellcheck.yml) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

One-script deployment of a **redroid (Android 13) cloud phone with Google
services (GMS)** on an ARM64 Ubuntu cloud instance, using Docker.

Built for the QingFeng OS cloud phone project (in development): an Android
phone that lives on a cloud server, keeps its data in a single portable
directory, and is reached privately over an SSH tunnel or Tailscale — never
through ports exposed to the public internet.

**Project status:** v0.1.0. The deployment toolkit is in active
development. End-to-end deployments are being verified across ARM cloud
providers, and verified results are recorded in `docs/` as they complete.
The script itself is complete and ready to run; the cloud phone it deploys
is still being brought up and tested, and this README does not claim
production usage.

## What it does

`deploy_redroid.sh` performs the whole setup, stopping at the first failure:

1. Installs base tools and Docker.
2. Loads the Android `binder` kernel module (with a clear stop and diagnosis
   if the cloud kernel does not ship it).
3. Builds a GMS-enabled redroid image with the community
   [redroid-script](https://github.com/ayasa520/redroid-script) project and
   MindTheGapps — no AOSP source build needed.
4. Starts the phone container with its data persisted to `~/redroid-data`,
   ADB bound to `127.0.0.1:5555` only.
5. Optionally starts `scrcpy-web` on localhost for browser casting.

## Quick start

Requirements: an ARM64 (aarch64) cloud instance, Ubuntu 24.04 LTS, enough
RAM for Android 13 (8 GB recommended), and outbound network access.

```bash
git clone https://github.com/a718983610-sys/qingfeng-cloudphone.git
cd qingfeng-cloudphone
cp config.example.env config.env   # optional, defaults work
sudo bash deploy_redroid.sh
adb connect 127.0.0.1:5555 && adb devices
```

## Configuration

See `config.example.env`: Android version, screen size/DPI, device model
spoofing, data directory, and the ADB bind address.

## Security notes

- ADB (5555) and casting (8000) are bound to localhost by design. Exposing
  ADB publicly is equivalent to handing out the phone. Use an SSH tunnel or
  Tailscale.
- The container runs `--privileged`, which redroid requires. Run it only on
  a host you control.
- Cloud instance IPs are datacenter IPs. Some apps and regional services
  treat them accordingly; see `docs/troubleshooting.md`.

## Migration

The phone is its data directory. Stop the container, copy `~/redroid-data`
to a new ARM host, run the script there, and mount the directory back at
`/data` — apps, accounts and data come back as they were. Details in
`docs/migration.md`.

## Known limitations

- Containerized Android cannot pass strong Play Integrity checks; a small
  number of banking-grade apps may refuse to run. Everyday apps are
  unaffected.
- Kernels without the binder module cannot run redroid; the script detects
  this and stops instead of failing silently.

## 中文简介

在 ARM64 云服务器（Ubuntu 24.04）上一键部署带谷歌服务（GMS）的
redroid 安卓 13 云手机：Docker 部署、数据目录可整体搬家、ADB 只绑本机
经 SSH 隧道/Tailscale 访问。部署步骤、排错与搬家方法见 `docs/`。

## License

MIT — see `LICENSE`.
