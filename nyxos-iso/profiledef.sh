#!/usr/bin/env bash
# NyxOS 26.11 archiso profile

iso_name="nyxos"
iso_label="NYXOS_26_11"
iso_publisher="NyxOS Custom Builder"
iso_application="NyxOS 26.11 Live/Install ISO"
iso_version="26.11"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-ia32.grub.esp' 'uefi-x64.grub.esp'
           'uefi-ia32.grub.eltorito' 'uefi-x64.grub.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '15' '-b' '1M')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/usr/local/bin/nyxos-install"]="0:0:755"
)
