inherit kernel-pando

python do_overlays() {
    import glob, re, os
    overlays = []
    source_path = d.getVar('S', True) + '/arch/' + d.getVar('ARCH',True) + '/boot/dts/overlays/*-overlay.dts'
    for overlay in glob.glob(source_path):
        overlays.append(re.sub(r'-overlay.dts','.dtbo',overlay).split('dts/')[-1])
    for dtbo in overlays:
        d.setVar('KERNEL_DEVICETREE', d.getVar('KERNEL_DEVICETREE', True) + ' ' + dtbo)

    if not os.path.exists(d.getVar('DEPLOY_DIR_IMAGE')):
        os.makedirs(d.getVar('DEPLOY_DIR_IMAGE'))
    f = open(d.getVar('DEPLOY_DIR_IMAGE') + '/overlays.txt', "w")
    f.write(d.getVar('KERNEL_DEVICETREE', True))
    f.close
}

# KERNEL_DEVICETREE has a local scope in each function, even in a :prepend,
# so the only way to alter it to include all overlays is by using the prefuncs
do_install[prefuncs] += "do_overlays"
do_compile[prefuncs] += "do_overlays"
do_deploy[prefuncs] += "do_overlays"

# we have to ensure the overlays list is populated so that
# the boot partition can be generated correctly
do_install[nostamp] = "1"

# Built-in SPI drivers needed for API EEPROM update
# Otherwise on A/B rollback modules won't match running kernel
PANDO_CONFIGS:append:raspberrypi4-64 = " pieeprom"
PANDO_CONFIGS[pieeprom] = " \
    CONFIG_SPI=y \
    CONFIG_SPI_BCM2835=y \
    CONFIG_SPI_SPIDEV=y \
"

PANDO_CONFIGS:append:raspberrypicm4-ioboard-sb = " dwc2"
PANDO_CONFIGS[dwc2] = "CONFIG_USB_DWC2=y"
