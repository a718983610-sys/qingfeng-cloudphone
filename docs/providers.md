# Provider compatibility

`deploy_redroid.sh` targets **ARM64 Ubuntu** hosts. Whether a given cloud
instance works depends mostly on one thing: the host kernel must provide
the Android binder devices (`/dev/binder`, `/dev/hwbinder`,
`/dev/vndbinder`). Cloud kernels differ, so results are recorded here as
they are verified end-to-end. **A row is only marked "Verified" after a
full run: container up, Android booted, ADB connected over the tunnel.**

## Matrix

| Provider | Instance | Kernel / notes | Status |
|----------|----------|----------------|--------|
| AWS EC2 | t4g family (Graviton, ARM64) | Ubuntu 24.04 | Verification in progress |
| Alibaba Cloud | g8y family (ARM64) | Ubuntu 24.04 | Planned |
| Google Cloud | t2a family (Ampere, ARM64) | Ubuntu 24.04 | Planned |
| Oracle Cloud | A1 family (Ampere, ARM64) | Ubuntu 24.04 | Planned |

## How to add a result

Open an issue using the *Provider compatibility report* template with:

- Provider, region, and exact instance type
- `uname -r` output on the host
- Whether `/dev/binder`, `/dev/hwbinder`, `/dev/vndbinder` exist
  (before and after loading `binder_linux`)
- Docker version
- How far the deployment got, and the first error if it stopped

Reports of failures are as useful as successes — they tell the next
person which instance to avoid.
