SUMMARY = "Helloworld test"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
	file://helloworld.sh \
	file://helloworld.pro \
	file://main.cpp \
	"

SRCREV = "${AUTOREV}"
S = "${WORKDIR}"
PR = "r0"
DEPENDS = " qtbase"

inherit update-rc.d
inherit qmake5

do_install_append() {
	install -d ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/helloworld.sh ${D}${sysconfdir}/init.d/helloworld
}

INITSCRIPT_NAME = "helloworld"
INITSCRIPT_PARAMS = "start 99 5 . stop 00 0 1 6 ."

#S = "${WORKDIR}"
#PR = "r0"
#DEPENDS = " qtbase"

#inherit qmake5
