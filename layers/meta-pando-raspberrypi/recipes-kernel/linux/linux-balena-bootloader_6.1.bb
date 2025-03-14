LINUX_VERSION ?= "6.1.64"
LINUX_RPI_BRANCH ?= "rpi-6.1.y"
LINUX_RPI_KMETA_BRANCH ?= "yocto-6.1"

SRCREV_machine = "dad5d57939cfae7af363e7c9862b59d33d96794b"
SRCREV_meta = "f845a7f37d7114230d6609e2bd630070f2f6cd9b"

KMETA = "kernel-meta"

SRC_URI = " \
          git://github.com/raspberrypi/linux.git;name=machine;branch=${LINUX_RPI_BRANCH};protocol=https \
          git://git.yoctoproject.org/yocto-kernel-cache;type=kmeta;name=meta;branch=${LINUX_RPI_KMETA_BRANCH};destsuffix=${KMETA} \
"
SRC_URI:remove = "file://initramfs-image-bundle.cfg"
SRC_URI:remove = "file://vc4graphics.cfg"
SRC_URI:remove = "file://default-cpu-governor.cfg"

require recipes-kernel/linux/linux-raspberrypi.inc

inherit pando-bootloader

PANDO_DEFCONFIG_NAME = "${KBUILD_DEFCONFIG}"

PANDO_CONFIGS:append = " \
    rpisense \
    "

PANDO_CONFIGS[rpisense] = " \
    CONFIG_MFD_RPISENSE_CORE=n \
    CONFIG_FB_RPISENSE=n \
    "

PANDO_CONFIGS_DEPS[secureboot] += " \
    CONFIG_MODULE_SIG_FORMAT=y \
    CONFIG_PKCS7_MESSAGE_PARSER=y \
    CONFIG_SYSTEM_DATA_VERIFICATION=y \
    CONFIG_SIGNED_PE_FILE_VERIFICATION=y \
    "

PANDO_CONFIGS[secureboot] += " \
    CONFIG_KEXEC_IMAGE_VERIFY_SIG=y \
    "

do_deploy:append () {
    BOOTENV_FILE="${DEPLOYDIR}/${KERNEL_PACKAGE_NAME}/bootenv"
    grub-editenv "${BOOTENV_FILE}" create
    grub-editenv "${BOOTENV_FILE}" set "resin_root_part=A"
    grub-editenv "${BOOTENV_FILE}" set "bootcount=0"
    grub-editenv "${BOOTENV_FILE}" set "upgrade_available=0"
}

do_deploy[depends] += " grub-native:do_populate_sysroot"

KERNEL_DTC_FLAGS += "-@ -H epapr"

INITRAMFS_IMAGE = "pando-image-bootloader-initramfs"

KERNEL_PACKAGE_NAME = "pando-bootloader"

KERNEL_DEVICETREE = "${RPI_KERNEL_DEVICETREE}"

PROVIDES = "virtual/pando-bootloader"
