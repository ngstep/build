# NgSTEP Build System for FreeBSD

This repository contains a minimal, modular build system for NgSTEP using [Poudriere](https://github.com/freebsd/poudriere) on FreeBSD 15.0-CURRENT with pkgbase.

It automates port building, jail setup, and overlay integration, and prepares packages for ISO creation or host installation. It is intended to support reproducible builds of a full NgSTEP system.

---

## Requirements

- FreeBSD 15.0-CURRENT
- `zfs` enabled with pool name `zroot`
- `git`, `poudriere`, and `sudo` installed

---

## Directory Layout
```
├── Makefile # BSD make-compatible targets: ports, install, iso, clean
├── functions.sh # Main shell logic: ZFS setup, poudriere, etc.
├── poudriere.conf # Default poudriere config used for this build
├── ngstep-packages.list # List of NgSTEP ports to build with poudriere
└── ports-overlay/ # Overlay for poudriere containing ports for NgSTEP
```

## Usage

All build logic is exposed via the top-level `Makefile`. Run these commands with **sudo**:

### 1. Build NgSTEP ports
```
sudo make ports
```

### 2. Install packages to host (WIP)
```
sudo make install
```

### 3. Create ISO image (WIP)
```
sudo make iso
```

### 4. Destroy build datasets
```
sudo make clean
```