include pando-image.inc

init_board_config() {
    sed -i 's/$/ root=LABEL=flash-rootA flasher migrate/g' "${PANDO_BOOT_WORKDIR}/cmdline.txt"
}
