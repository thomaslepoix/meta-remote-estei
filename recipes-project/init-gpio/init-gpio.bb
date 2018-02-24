SUMMARY = "GPIO initialization for remote shield"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"


SRC_URI = " file://init-gpio.sh "

SRCREV = "${AUTOREV}"

inherit update-rc.d

do_install() {
	install -d ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/init-gpio.sh ${D}${sysconfdir}/init.d/init-gpio
}

INITSCRIPT_NAME = "init-gpio"
INITSCRIPT_PARAMS = "start 97 5 . stop 00 0 1 6 ."
