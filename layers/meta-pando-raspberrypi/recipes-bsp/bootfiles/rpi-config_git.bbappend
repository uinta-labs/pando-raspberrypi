do_deploy:append() {
    # Enable i2c by default
    echo "dtparam=i2c_arm=on" >>${DEPLOYDIR}/bootfiles/config.txt
    # Enable SPI by default
    echo "dtparam=spi=on" >>${DEPLOYDIR}/bootfiles/config.txt
    # Disable firmware splash by default
    echo "disable_splash=1" >>${DEPLOYDIR}/bootfiles/config.txt
    # Disable firmware warnings showing in non-debug images
    if ! ${@bb.utils.contains('DISTRO_FEATURES','osdev-image','true','false',d)}; then
        echo "avoid_warnings=1" >>${DEPLOYDIR}/bootfiles/config.txt
    fi
    # Enable audio (loads snd_bcm2835)
    echo "dtparam=audio=on" >> ${DEPLOYDIR}/bootfiles/config.txt
}

do_deploy:append:fincm3() {
	# Use the Balena Fin device tree overlay
	echo "dtoverlay=balena-fin" >> ${DEPLOYDIR}/bootfiles/config.txt
}

# On Raspberry Pi 3 and Raspberry Pi Zero WiFi, serial ttyS0 console is only
# usable if ENABLE_UART = 1. On OS development images, we want serial console
# available, production devices can enable it with a configuration variable.
ENABLE_UART ?= "${@bb.utils.contains('DISTRO_FEATURES','osdev-image','1','0',d)}"
