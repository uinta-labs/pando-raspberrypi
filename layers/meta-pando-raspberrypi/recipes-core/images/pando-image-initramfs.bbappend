# PACKAGE_INSTALL:remove:revpi = "initramfs-module-migrate"

IMAGE_ROOTFS_MAXSIZE = "65536"
# IMAGE_ROOTFS_MAXSIZE = "352256"

# PACKAGE_INSTALL:append:raspberrypicm4-ioboard-sb = " initramfs-module-kexec-pi4-fwgpio"
# IMAGE_ROOTFS_MAXSIZE:raspberrypicm4-ioboard-sb = "51200"

# increase initramfs maxsize to 40 MiB
IMAGE_ROOTFS_MAXSIZE:raspberrypi5 = "40960"
IMAGE_ROOTFS_MAXSIZE:raspberrypi4-64 = "40960"
