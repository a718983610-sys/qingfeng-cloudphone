# Security Policy

## Supported versions

| Version | Supported |
|---------|-----------|
| 0.1.x   | Yes       |

## Reporting a vulnerability

Please report security issues **privately** through GitHub's
"Report a vulnerability" button under this repository's Security tab.
Do not open a public issue for an unpatched vulnerability.

This project deploys containers with elevated privileges on the user's
own server, so reports about privilege flags, exposed ports, image
provenance, or credential handling in the script are especially welcome.

Please include:

- The script version and host environment (provider, instance type,
  kernel version).
- Steps to reproduce.
- The impact you believe it has.

You can expect an acknowledgement within 7 days. Fixes are released as
patch versions and noted in `CHANGELOG.md`.
