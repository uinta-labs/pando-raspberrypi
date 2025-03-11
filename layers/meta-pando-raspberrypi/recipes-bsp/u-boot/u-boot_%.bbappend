inherit pando-u-boot
UBOOT_KCONFIG_SUPPORT = "1"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Remove patch inherited from meta-resin. This needs to be rebased for v2018.07
SRC_URI:remove = " file://resin-specific-env-integration-kconfig.patch "

SRCREV="866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e"

### file://rpi4-include-configs-Use-config-defaults.patch \
### file://Revert-remove-include-config_defaults.h.patch
### file://0002-raspberrypi-Disable-simple-framebuffer-support.patch
### file://u-boot-Remove-usb-start-from-CONFIG_PREBOOT.patch

RPI_PATCHES = " \
    file://rpi-Use-CONFIG_OF_BOARD-instead-of-CONFIG_EMBED.patch \
    file://increase-usb-interface-nr.patch \
    file://0001-avoid-block-uart-write.patch \
"

SRC_URI += " \
    file://0001-Integrate-machine-independent-resin-environment-conf.patch \
    ${RPI_PATCHES} \
"

# # These patches were obtained from
# # https://github.com/home-assistant/operating-system/pull/1557
# # and we can update to u-boot 2022 once the following topic
# # https://github.com/home-assistant/operating-system/pull/1761#issuecomment-1062992660
# # is clarified.
# SRC_URI:append:raspberrypicm4-ioboard = " \
#     file://0011-enable-nvme-cm4.patch \
#     file://0012-rpi-add-NVMe-to-boot-order.patch \
#     file://0013-Revert-nvme-Correct-the-prps-per-page-calculation.patch \
#     file://0014-nvme-improve-readability-of-nvme_setup_prps.patch \
#     file://0015-nvme-Use-pointer-for-CPU-addressed-buffers.patch \
#     file://0016-nvme-translate-virtual-addresses-bus-address.patch \
#     file://0017-use-temp-ptr-to-buffer.patch \
# "

# # Disable flasher check since it starts usb unnecessarily
# # and we don't generate flasher images for any of the RPIs.
# # Also, add a retry count limit for the uart on u-boot 2020.x
# SRC_URI:append = " \
#     file://0001-rpi-Disable-image-flasher-check.patch \
#     file://serial_pl01x-Add-retry-limit-when-writing-to-uart-co.patch \
# "

PANDO_UBOOT_DEVICE_TYPES:append = " usb"

# The CM4 Rpi firmware now supports booting from a NVME,
# so we can add nvme to the list of balena boot devices
PANDO_UBOOT_DEVICE_TYPES:append:raspberrypicm4-ioboard = " nvme"

# SRC_URI:append:raspberrypi4-64 = " \
#     file://pi4-fix-crash-when-issuing-usb-reset.patch \
# "
