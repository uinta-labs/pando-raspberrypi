DESCRIPTION = "Shpool"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit systemd deploy pando-configurable cargo_bin

do_compile[network] = "1"

SRC_URI = "git://github.com/shell-pool/shpool.git;protocol=https;branch=master"

SRC_URI += "file://shpool.socket \
           file://shpool.service \
           "

SRCREV = "de25aef0d9bbff608a9665b5006f932bc64d1046"
S = "${WORKDIR}/git"
CARGO_SRC_DIR = ""

LIC_FILES_CHKSUM = " \
    file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57 \
"