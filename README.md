# NyxOS 26.11 — Bootable ISO Build Kit

This kit contains the complete `archiso` profile, compositor configuration (Hyprland blur, animations, and gesture bindings), package manifest, live disk installer (`nyxos-install`), and a **GitHub Actions workflow** so you can build the `.iso` in the cloud with zero local Linux setup.

## Option 1: Build Automatically on GitHub (No Local Setup)
1. Extract this archive and push its contents (including `.github/workflows/build-iso.yml`) to a new GitHub repository.
2. Open the **Actions** tab in your GitHub repository — **Build NyxOS Bootable ISO** runs automatically on push (or click **Run workflow**).
3. When it finishes, download **`nyxos-26.11-x86_64-iso`** from the **Artifacts** section at the bottom of the workflow run.

## Option 2: Compile Locally (Arch Linux or Docker)
```bash
tar -xzf nyxos-26.11-archiso-kit.tar.gz
chmod +x build-iso.sh
./build-iso.sh
```
The bootable UEFI + BIOS image will be written to `./out/nyxos-26.11-x86_64.iso`.

## Boot & Install
- **Virtual Machine (QEMU / VirtualBox / VMware)**: Attach the `.iso` as an optical drive and enable EFI + 3D acceleration.
- **Physical USB Drive**: Flash with `dd if=out/nyxos-26.11-x86_64.iso of=/dev/sdX bs=4M status=progress oflag=sync` or Ventoy/Rufus.
- **Install to Disk**: Once booted into the live session, run `sudo nyxos-install`.
