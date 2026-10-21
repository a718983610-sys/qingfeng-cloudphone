# Troubleshooting

## binder_linux fails to load
The host kernel does not ship the Android binder module, or the extra
modules package is missing. The script installs
`linux-modules-extra-$(uname -r)` first. If loading still fails, switch to
the generic Ubuntu kernel or an image built with binder support — redroid
cannot run without binder, so do not try to skip this step.

## GMS image build fails
The script prints the fallback: pull the plain AOSP image
(`redroid/redroid:13.0.0_64only-latest`) to verify the rest of the pipeline,
then retry the redroid-script build with network access to GitHub and the
GApps mirrors.

## An app refuses to run / Play Integrity
Containerized Android passes basic integrity only. Apps that require
DEVICE or STRONG integrity (some banking apps) may refuse. This is a
platform limitation, not a deployment bug.

## ADB connection refused
Confirm the container is up (`docker ps`), that nothing else owns port
5555, and that you are connecting through the host itself or a tunnel —
ADB is intentionally not reachable from the public internet.

## Datacenter IP side effects
The phone exits through the cloud provider's IP range. Region-locked or
risk-sensitive services may behave differently than on a residential
connection. Do not sign in to accounts that are sensitive to datacenter
logins from this phone.
