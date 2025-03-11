FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:${THISDIR}/${MACHINE}:"

SRC_URI:append:raspberrypi4-superhub = " \
	file://0001-Add-gpio-wdt-DT-overlay-for-Phoenix-Board.patch \
	file://0002-Add-infineon-tpm-DT-overlay-for-Phoenix-Board.patch \
	file://0003-Add-spi1-DT-overlay-for-Phoenix-Board.patch \
	file://0004-Add-SD-host-DT-overlay-for-Phoenix-Board.patch \
"

SRC_URI:append = " \
	file://0002-wireless-wext-Bring-back-ndo_do_ioctl-fallback.patch \
	file://0001-Add-npe-x500-m3-overlay.patch \
	file://0006-overlays-Add-Hyperpixel4-overlays.patch \
	file://0001-Add-tpm-slb9670-tis-spi-DT-overlay.patch \
	file://0001-seeed-studio-can-bus-v2-Add-dtbo-for-this-can-bus.patch \
	file://0011-USB-serial-Add-support-for-more-Quectel-modules.patch \
	file://0001-waveshare-sim7600-Add-dtbo-for-this-modem.patch \
	file://0001-overlays-Add-overlay-for-Seeed-reComputer-R1000.patch \
	file://0001-overlays-Add-overlay-for-RPI-PLC-SC16IS752.patch \
"

PANDO_CONFIGS:append = " fbtft"
PANDO_CONFIGS[fbtft] = " \
    CONFIG_STAGING=y \
    CONFIG_FB_TFT=m \
    CONFIG_FB_TFT_AGM1264K_FL=m \
    CONFIG_FB_TFT_BD663474=m \
    CONFIG_FB_TFT_HX8340BN=m \
    CONFIG_FB_TFT_HX8347D=m \
    CONFIG_FB_TFT_HX8353D=m \
    CONFIG_FB_TFT_ILI9163=m \
    CONFIG_FB_TFT_ILI9320=m \
    CONFIG_FB_TFT_ILI9325=m \
    CONFIG_FB_TFT_ILI9340=m \
    CONFIG_FB_TFT_ILI9341=m \
    CONFIG_FB_TFT_ILI9481=m \
    CONFIG_FB_TFT_ILI9486=m \
    CONFIG_FB_TFT_PCD8544=m \
    CONFIG_FB_TFT_RA8875=m \
    CONFIG_FB_TFT_S6D02A1=m \
    CONFIG_FB_TFT_S6D1121=m \
    CONFIG_FB_TFT_SSD1289=m \
    CONFIG_FB_TFT_SSD1306=m \
    CONFIG_FB_TFT_SSD1331=m \
    CONFIG_FB_TFT_SSD1351=m \
    CONFIG_FB_TFT_ST7735R=m \
    CONFIG_FB_TFT_TINYLCD=m \
    CONFIG_FB_TFT_TLS8204=m \
    CONFIG_FB_TFT_UC1701=m \
    CONFIG_FB_TFT_UPD161704=m \
    "


PANDO_CONFIGS:append = " ${@configure_from_version("5.17", "", " fb_tft_watterott", d)}"
PANDO_CONFIGS[fb_tft_watterott] = "CONFIG_FB_TFT_WATTEROTT=m"

PANDO_CONFIGS:append = " pca955_gpio_expander"
PANDO_CONFIGS[pca955_gpio_expander] = " \
    CONFIG_GPIO_PCA953X=y \
    CONFIG_GPIO_PCA953X_IRQ=y \
    "

KERNEL_MODULE_PROBECONF += "rtl8192cu"
module_conf_rtl8192cu = "blacklist rtl8192cu"

# requested by customer (support for Kontron PLD devices)
PANDO_CONFIGS:append = " gpio_i2c_kempld"
PANDO_CONFIGS_DEPS[gpio_i2c_kempld] = " \
    CONFIG_GPIOLIB=y \
    CONFIG_I2C=y \
    CONFIG_HAS_IOMEM=y \
    CONFIG_MFD_KEMPLD=m \
"
PANDO_CONFIGS[gpio_i2c_kempld] = " \
    CONFIG_GPIO_KEMPLD=m \
    CONFIG_I2C_KEMPLD=m \
"

# make sure watchdog gets enabled no matter of the BSP changes
PANDO_CONFIGS:append = " rpi_watchdog"
PANDO_CONFIGS_DEPS[rpi_watchdog] = " \
    CONFIG_WATCHDOG=y \
"
PANDO_CONFIGS[rpi_watchdog] = " \
    CONFIG_BCM2835_WDT=y \
"

PANDO_CONFIGS:append = " kvaser_usb_can_driver"

PANDO_CONFIGS[kvaser_usb_can_driver] = " \
    CONFIG_CAN_KVASER_USB=m \
"

PANDO_CONFIGS:append = " mcp251x_can_driver"

PANDO_CONFIGS[mcp251x_can_driver] = " \
    CONFIG_CAN_MCP251X=m \
"

PANDO_CONFIGS_DEPS[mcp251x_can_driver] = " \
    CONFIG_SPI=y \
    CONFIG_HAS_DMA=y \
"

PANDO_CONFIGS:append = " can_calc_bittiming"

PANDO_CONFIGS[can_calc_bittiming] = " \
		CONFIG_CAN_CALC_BITTIMING=y \
"

PANDO_CONFIGS_DEPS[can_calc_bittiming] = " \
		CONFIG_CAN_DEV=y \
"

PANDO_CONFIGS:append = " ds1307_rtc_driver"

PANDO_CONFIGS[ds1307_rtc_driver] = " \
    CONFIG_RTC_DRV_DS1307=m \
"

PANDO_CONFIGS_DEPS[ds1307_rtc_driver] = " \
    CONFIG_I2C=y \
"

PANDO_CONFIGS:append = " sc16is7xx_serial_driver"

PANDO_CONFIGS[sc16is7xx_serial_driver] = " \
    CONFIG_SERIAL_SC16IS7XX=m \
"

PANDO_CONFIGS_DEPS[sc16is7xx_serial_driver] = " \
    CONFIG_I2C=y \
"

PANDO_CONFIGS:append = " mcp3422_adc_driver"

PANDO_CONFIGS[mcp3422_adc_driver] = " \
    CONFIG_MCP3422=m \
"

PANDO_CONFIGS_DEPS[mcp3422_adc_driver] = " \
    CONFIG_I2C=y \
"

PANDO_CONFIGS:append = " sd8787_pwrseq_driver"

PANDO_CONFIGS[sd8787_pwrseq_driver] = " \
    CONFIG_PWRSEQ_SD8787=m \
"

PANDO_CONFIGS_DEPS[sd8787_pwrseq_driver] = " \
    CONFIG_OF=y \
"

PANDO_CONFIGS:append = " serial_8250"
PANDO_CONFIGS[serial_8250] = " \
    CONFIG_SERIAL_8250=y \
    CONFIG_SERIAL_8250_CONSOLE=y \
    CONFIG_SERIAL_8250_NR_UARTS=1 \
    CONFIG_SERIAL_8250_EXTENDED=y \
    CONFIG_SERIAL_8250_SHARE_IRQ=y \
    CONFIG_SERIAL_8250_BCM2835AUX=y \
"

PANDO_CONFIGS:append:rt-rpi-300 = " rtrpi300cfgs"
PANDO_CONFIGS[rtrpi300cfgs] = " \
    CONFIG_RTC_DRV_RX8010=m \
    CONFIG_SPI=y \
    CONFIG_SPI_BCM2835=m \
    CONFIG_CH432T_SPI=m \
"

# The Pi3-64 and Pi4-64 are the only boards very low on rootfs space for now
# so we add this as per https://github.com/balena-os/meta-balena/pull/2411
PANDO_CONFIGS:append:raspberrypi4-64 = " optimize-size"
PANDO_CONFIGS:append:raspberrypi3-64 = " optimize-size"
PANDO_CONFIGS[optimize-size] = " \
    CONFIG_CC_OPTIMIZE_FOR_SIZE=y \
"

PANDO_CONFIGS:append = " iio_pressure_drivers"
PANDO_CONFIGS[iio_pressure_drivers] = " \
    CONFIG_BMP280=m \
"

# Fix dtbo loading on 64bits,
# see commit 949b88bb for details
get_cc_option () {
		# Check if KERNEL_CC supports the option "file-prefix-map".
		# This option allows us to build images with __FILE__ values that do not
		# contain the host build path.
		if ${KERNEL_CC} -Q --help=joined | grep -q "\-ffile-prefix-map=<old=new>"; then
			echo "-ffile-prefix-map=${S}=/kernel-source/"
		fi
}
do_compile:append() {
    if [ "${SITEINFO_BITS}" = "64" ]; then
        cc_extra=$(get_cc_option)
        oe_runmake dtbs CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
    fi
}

do_configure:append(){
    mkdir -p ${STAGING_KERNEL_DIR}/arch/arm/boot/dts/broadcom
    cp ${STAGING_KERNEL_DIR}/arch/arm/boot/dts/bcm* ${STAGING_KERNEL_DIR}/arch/arm/boot/dts/broadcom/
    cp ${STAGING_KERNEL_DIR}/arch/arm/boot/dts/rp1.dtsi ${STAGING_KERNEL_DIR}/arch/arm/boot/dts/broadcom/
}