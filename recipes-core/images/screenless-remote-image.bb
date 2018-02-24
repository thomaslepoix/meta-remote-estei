DESCRIPTION = "Screenless remote image"
LICENSE = "MIT"
export IMAGE_BASENAME = "screenless-remote-image"
include recipes-core/images/rpi-basic-image.bb

inherit extrausers
EXTRA_USERS_PARAMS = "\	
	usermod -P estei root; "

CONNECTIVITY = " \
	linux-firmware \
	i2c-tools \
	python-smbus \
	bridge-utils \
	hostapd \
	iptables \
	wpa-supplicant \
"

DISTRO_FEATURES += "wifi"
MACHINE_FEATURES += "wifi"
IMAGE_INSTALL += " \
	${CONNECTIVITY} \
	init-gpio \
	resetnet \
	helloworld \
"
