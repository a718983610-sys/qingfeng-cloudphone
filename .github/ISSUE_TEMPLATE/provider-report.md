---
name: Provider compatibility report
about: Report a deployment result on a specific cloud provider / instance type
title: "[provider] "
labels: compatibility
---

**Provider / region / instance type**

**Date tested**

**Host kernel (`uname -r`)**

**Binder devices present?**
- `/dev/binder`:
- `/dev/hwbinder`:
- `/dev/vndbinder`:
- After loading `binder_linux` (if you tried):

**Docker version**

**Result**
- [ ] Worked end-to-end (container up, Android booted, ADB connected)
- [ ] Failed — fill in the section below

**Failure symptoms (if it failed)**
What exactly did you see? (script stopped at which step, error message,
container state, black screen, etc.)

**Steps to reproduce**
1.
2.
3.

**Relevant logs**
(First error lines from the script output, `docker logs`, or `adb logcat`)
