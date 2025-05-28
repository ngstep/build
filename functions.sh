#!/bin/sh

main() {
  export POUDRIERE_ETC="/zroot/ngstep-build/etc"
  check_requirements
}

check_requirements() {
  if [ "$(id -u)" != "0" ]; then
    echo "Must be run as root"
    exit 1
  fi
  for cmd in git poudriere; do
    command -v "$cmd" >/dev/null 2>&1 || {
      echo "$cmd is required but not found"
      exit 1
    }
  done
}

create_datasets() {
  base="zroot/ngstep-build"
  for ds in "$base" "$base/etc" "$base/distfiles"; do
    zfs list -H -o name "$ds" >/dev/null 2>&1 || zfs create "$ds"
  done
}

install_poudriere_conf() {
  [ -f "$POUDRIERE_ETC/poudriere.conf" ] || cp ./poudriere.conf "$POUDRIERE_ETC/poudriere.conf"
}

poudriere_jail() {
  poudriere -e "$POUDRIERE_ETC" jail -l | grep -q ngstep_base || \
    poudriere -e "$POUDRIERE_ETC" jail -c -j ngstep_base -m pkgbase=base_latest -U https://pkg.freebsd.org/ -v 15 -a amd64 -K GENERIC
  poudriere -e "$POUDRIERE_ETC" jail -u -j ngstep_base
}

poudriere_ports() {
  poudriere -e "$POUDRIERE_ETC" ports -l | grep -q ngstep_ports || \
    poudriere -e "$POUDRIERE_ETC" ports -c -p ngstep_ports
  poudriere -e "$POUDRIERE_ETC" ports -u -p ngstep_ports
}

poudriere_overlay() {
  poudriere -e "$POUDRIERE_ETC" ports -l | grep -q ngstep_overlay || \
    poudriere -e "$POUDRIERE_ETC" ports -c -p ngstep_overlay -m null -M "$(pwd)/ports-overlay"
}

poudriere_bulk() {
  poudriere -e "$POUDRIERE_ETC" bulk -b latest -j ngstep_base -p ngstep_ports -O ngstep_overlay $(cat ngstep-ports.list)
}

ports_target() {
  main
  create_datasets
  install_poudriere_conf
  poudriere_jail
  poudriere_ports
  poudriere_overlay
  poudriere_bulk
}

install_target() {
  ports_target
  echo "[TODO] Register pkg repo on host"
}

iso_target() {
  ports_target
  echo "[TODO] Create ISO from packages"
}

clean_zfs() {
  zfs destroy -r zroot/ngstep-build || echo "Nothing to clean"
}
