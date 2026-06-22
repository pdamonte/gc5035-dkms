#!/usr/bin/env bash
set -euo pipefail

PACKAGE_NAME=gc5035-dkms
PACKAGE_VERSION=0.1
MODULE_NAME=gti5035

if [ "$(id -u)" -ne 0 ]; then
	echo "Run as root: sudo $0" >&2
	exit 1
fi

modprobe -r "${MODULE_NAME}" 2>/dev/null || true
dkms remove -m "${PACKAGE_NAME}" -v "${PACKAGE_VERSION}" --all || true
rm -f /etc/modules-load.d/gc5035.conf
rm -rf "/usr/src/${PACKAGE_NAME}-${PACKAGE_VERSION}"
depmod
