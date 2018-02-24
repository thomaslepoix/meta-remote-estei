SUMMARY = "Retry to connect to MASTER_SE"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"


SRC_URI = " file://resetnet.sh "

SRCREV = "${AUTOREV}"

inherit update-rc.d

do_install() {
	install -d ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/resetnet.sh ${D}${sysconfdir}/init.d/resetnet
}

INITSCRIPT_NAME = "resetnet"
INITSCRIPT_PARAMS = "start 98 5 ."
