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
      set -euo pipefail
      pacman-key --init
      pacman -Syu --noconfirm archiso grub
      mkdir -p /tmp/profile
      cp -r /usr/share/archiso/configs/releng/. /tmp/profile/
      cp -r /build/nyxos-iso/. /tmp/profile/
      chmod +x /tmp/profile/profiledef.sh /tmp/profile/airootfs/usr/local/bin/nyxos-install
      mkarchiso -v -w /tmp/work -o /build/out /tmp/profile
    "
else
  echo "Error: Run on Arch Linux (with archiso and grub installed) or install Docker to compile the .iso." >&2
  exit 1
fi

echo "[NyxOS] Done! Bootable ISO generated in ${OUT_DIR}/"
