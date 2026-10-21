# Migration guide

The whole phone lives in the data directory (default `~/redroid-data`),
mounted at `/data` in the container. Moving providers is therefore a
file copy, not a rebuild.

1. On the old host: `docker stop redroid`
2. Archive the data: `tar czf redroid-data.tgz ~/redroid-data`
3. Copy the archive to the new ARM64 host.
4. On the new host, clone this repository and run `deploy_redroid.sh`
   (this rebuilds the base image and tooling).
5. Stop the fresh container, replace its data directory with the archived
   one, and start it again. Apps, accounts and data are restored as-is.

Keep the archive private: it contains app data and signed-in sessions,
exactly like a physical phone backup.
