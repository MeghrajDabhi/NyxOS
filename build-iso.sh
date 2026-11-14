#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT_DIR="${SCRIPT_DIR}/out"
mkdir -p "${OUT_DIR}"

if command -v mkarchiso >/dev/null 2>&1; then
  echo "[NyxOS] Building bootable ISO natively with mkarchiso..."
  sudo mkarchiso -v -w /tmp/nyxos-archiso-work -o "${OUT_DIR}" "${SCRIPT_DIR}/nyxos-iso"
elif command -v docker >/dev/null 2>&1; then
  echo "[NyxOS] Building bootable ISO inside privileged Arch Linux container..."
  docker run --rm --privileged \
    -v "${SCRIPT_DIR}:/build" \
    archlinux:latest bash -c "
      pacman -Syu --noconfirm archiso &&
      cp -r /usr/share/archiso/configs/releng/* /tmp/profile/ 2>/dev/null || mkdir -p /tmp/profile &&
      cp -r /usr/share/archiso/configs/releng/. /tmp/profile/ &&
      cp -r /build/nyxos-iso/. /tmp/profile/ &&
      mkarchiso -v -w /tmp/work -o /build/out /tmp/profile
    "
else
  echo "Error: Run on Arch Linux (with archiso installed) or install Docker to compile the .iso." >&2
  exit 1
fi

echo "[NyxOS] Done! Bootable ISO generated in ${OUT_DIR}/"
