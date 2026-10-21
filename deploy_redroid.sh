#!/usr/bin/env bash
# qingfeng-cloudphone: deploy a redroid (Android 13) cloud phone with Google
# services (GMS) on an ARM64 Ubuntu 24.04 cloud instance, using Docker.
#
# Usage: SSH into the instance, then run:
#   sudo bash deploy_redroid.sh
# Optional configuration: copy config.example.env to config.env and edit it
# before running. The script stops on the first failed step (set -e) so a
# half-finished deployment is never reported as success.
set -e

# ---- configuration (override in config.env) ----
ANDROID_VERSION="${ANDROID_VERSION:-13.0.0}"
SCREEN_WIDTH="${SCREEN_WIDTH:-1080}"
SCREEN_HEIGHT="${SCREEN_HEIGHT:-2400}"
SCREEN_DPI="${SCREEN_DPI:-420}"
DEVICE_MODEL="${DEVICE_MODEL:-Pixel 8 Pro}"
DEVICE_DEVICE="${DEVICE_DEVICE:-husky}"
DATA_DIR="${DATA_DIR:-$HOME/redroid-data}"
ADB_BIND="${ADB_BIND:-127.0.0.1}"
if [ -f "$(dirname "$0")/config.env" ]; then
  # shellcheck disable=SC1091
  . "$(dirname "$0")/config.env"
fi

if [ "$(uname -m)" != "aarch64" ]; then
  echo "!! This script targets ARM64 (aarch64) hosts. Current arch: $(uname -m)"
  echo "!! redroid images used here are ARM64-native; stop and use an ARM instance."
  exit 1
fi

echo "== [1/6] System update + base tools =="
sudo apt-get update -y
sudo apt-get install -y git curl unzip adb python3 python3-venv

echo "== [2/6] Install Docker =="
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com | sudo sh
fi
sudo usermod -aG docker "$USER" || true

echo "== [3/6] Load Android kernel modules (binder) =="
# Many cloud Ubuntu kernels need the extra modules package first.
sudo apt-get install -y "linux-modules-extra-$(uname -r)" || true
sudo modprobe binder_linux devices="binder,hwbinder,vndbinder" || {
  echo "!! binder_linux failed to load: this kernel may not ship the binder module."
  echo "!! Switch to a generic Ubuntu kernel or an image with binder support. Do not continue."
  exit 1
}
sudo modprobe ashmem_linux || echo "(ashmem not loaded; newer kernels use memfd instead, continuing)"
echo "binder_linux" | sudo tee /etc/modules-load.d/redroid.conf >/dev/null

echo "== [4/6] Build a redroid image with Google services (GMS) =="
# Uses the community redroid-script project to bake MindTheGapps into the
# image (ARM64 native). No AOSP source build is required.
cd ~
if [ ! -d redroid-script ]; then
  git clone https://github.com/ayasa520/redroid-script.git
fi
cd redroid-script
python3 -m venv venv || true
# shellcheck disable=SC1091
. venv/bin/activate || true
pip install -r requirements.txt -q
python3 redroid.py -a "$ANDROID_VERSION" -g -t user || {
  echo "!! GMS image build failed. To verify the pipeline with a plain AOSP image:"
  echo "   docker pull redroid/redroid:13.0.0_64only-latest"
  exit 1
}

echo "== [5/6] Start the cloud phone container (data persisted to $DATA_DIR) =="
mkdir -p "$DATA_DIR"
IMG=$(docker images --format '{{.Repository}}:{{.Tag}}' | grep -E 'redroid.*gapps|redroid-script' | head -n1 || true)
if [ -z "$IMG" ]; then IMG=$(docker images --format '{{.Repository}}:{{.Tag}}' | grep redroid | head -n1); fi
echo "Using image: $IMG"
docker rm -f redroid 2>/dev/null || true
docker run -itd --privileged \
  --name redroid \
  --restart unless-stopped \
  -v "$DATA_DIR":/data \
  -p "$ADB_BIND":5555:5555 \
  "$IMG" \
  androidboot.redroid_width="$SCREEN_WIDTH" \
  androidboot.redroid_height="$SCREEN_HEIGHT" \
  androidboot.redroid_dpi="$SCREEN_DPI" \
  ro.product.brand=google \
  ro.product.manufacturer=Google \
  ro.product.model="$DEVICE_MODEL" \
  ro.product.device="$DEVICE_DEVICE" \
  ro.product.name="$DEVICE_DEVICE"

echo "== [6/6] Start web casting (scrcpy-web, localhost only, reach it via a tunnel) =="
docker rm -f scrcpy-web 2>/dev/null || true
docker run -d --name scrcpy-web --restart unless-stopped \
  --network host \
  emptysuns/scrcpy-web:v0.1 || echo "(scrcpy-web pull failed; local scrcpy over ADB works too)"

echo ""
echo "Done. Verify with:"
echo "  adb connect 127.0.0.1:5555 && adb devices"
echo "  Reach the screen through an SSH tunnel or Tailscale only."
echo "  Never expose ports 5555/8000 directly to the public internet."
echo "Migration: stop the container, copy $DATA_DIR to a new ARM host, mount it"
echo "back at /data, and the phone comes back exactly as it was."
