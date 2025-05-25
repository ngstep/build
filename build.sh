#!/bin/sh

# Only run as superuser
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Make sure git is installed
if [ ! -f "/usr/local/bin/git" ] ; then
  echo "Git is required"
  echo "Please install it with pkg install git or pkg install git-lite first"
  exit 1
fi

# Make sure poudriere is installed
if [ ! -f "/usr/local/bin/poudriere" ] ; then
  echo "Poudriere is required"
  echo "Please install poudriere with pkg install poudriere or pkg install poudriere-devel first"
  exit 1
fi

create_datasets() {
  base="zroot/ngstep-build"
  datasets="$base $base/etc $base/distfiles"

  for ds in $datasets; do
    if ! zfs list -H -o name "$ds" >/dev/null 2>&1; then
      echo "Creating dataset: $ds"
      zfs create "$ds"
    else
      echo "Dataset already exists: $ds"
    fi
  done
}

# Define our custom poudriere etc directory
POUDRIERE_ETC="/zroot/ngstep-build/etc"

# Install poudriere.conf if it doesn't exist
install_poudriere_conf() {
  if [ ! -f "$POUDRIERE_ETC/poudriere.conf" ]; then
    echo "Installing default poudriere.conf to $POUDRIERE_ETC"
    cp $(pwd)/poudriere.conf "$POUDRIERE_ETC/poudriere.conf"
  fi
}

poudriere_jail() {
  # Check if jail exists
  poudriere -e "$POUDRIERE_ETC" jail -l | grep -q ngstep_base
  if [ $? -eq 1 ] ; then
    # If jail does not exist create it
    poudriere -e "$POUDRIERE_ETC" jail -c -j ngstep_base -m pkgbase=base_latest -U https://pkg.freebsd.org/ -v 15 -a amd64 -K GENERIC
  else
    # Update jail if it exists
    poudriere -e "$POUDRIERE_ETC" jail -u -j ngstep_base
  fi
}

poudriere_ports() {
  # Check if ports tree exists
  poudriere -e "$POUDRIERE_ETC" ports -l | grep -q ngstep_ports
  if [ $? -eq 1 ] ; then
    # If ports tree does not exist create it
    poudriere -e "$POUDRIERE_ETC" ports -c -p ngstep_ports
  else
    # Update ports if it exists
    poudriere -e "$POUDRIERE_ETC" ports -u -p ngstep_ports
  fi
}

poudriere_overlay() {
  # Only register overlay if not already registered
  poudriere -e "$POUDRIERE_ETC" ports -l | grep -q ngstep_overlay
  if [ $? -ne 0 ]; then
    echo "Registering existing overlay ports tree: ngstep_overlay"
    poudriere -e "$POUDRIERE_ETC" ports -c -p ngstep_overlay -m null -M "$(pwd)/ports-overlay"
  else
    echo "Overlay ports tree already registered: ngstep_overlay"
  fi
}

poudriere_bulk() {
  poudriere -e "$POUDRIERE_ETC" bulk -b latest -j ngstep_base -p ngstep_ports -O ngstep_overlay lang/libobjc2-devel
}

create_datasets
install_poudriere_conf
poudriere_jail
poudriere_ports
poudriere_overlay
poudriere_bulk