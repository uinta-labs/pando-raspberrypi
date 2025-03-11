# Enable the dwc2 driver
PANDO_CONFIGS:append:raspberrypicm4-ioboard-sb = " dwc2"
PANDO_CONFIGS[dwc2] = "CONFIG_USB_DWC2=y"
