# GC5035 / GCTI5035 DKMS driver

Linux DKMS package for the GalaxyCore GC5035-compatible sensor exposed on this
machine as ACPI HID `GCTI5035`.

The kernel module built by this package is named `gti5035`.

## Install on Ubuntu

```sh
sudo apt update
sudo apt install dkms build-essential v4l-utils python3-pil "linux-headers-$(uname -r)"
sudo ./install.sh
```

For a non-running target kernel:

```sh
sudo ./install.sh 6.x.y-z-generic
```

## Verify

```sh
lsmod | grep gti5035
dmesg | grep -Ei 'GCTI5035|gc5035|gti5035'
v4l2-ctl --list-devices
```

## Smoke Test

The capture helper auto-detects the media pipeline, so it does not depend on
fixed `/dev/media*`, `/dev/v4l-subdev*`, or `/dev/video*` numbering.

```sh
sudo tools/capture-gc5035.sh /tmp/gc5035.raw /tmp/gc5035.png
```

To force a media controller:

```sh
sudo MEDIA_DEV=/dev/media0 tools/capture-gc5035.sh /tmp/gc5035.raw /tmp/gc5035.png
```

## IPU6 Bridge Note

The Intel IPU6 bridge must know about `GCTI5035` for the camera to be connected
into the media graph. On kernels that do not already list it, add:

```c
IPU_SENSOR_CONFIG("GCTI5035", 1, 438000000),
```

to `drivers/media/pci/intel/ipu-bridge.c`.

## Uninstall

```sh
sudo ./uninstall.sh
```
