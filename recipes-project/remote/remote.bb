SUMMARY = "Main program"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
	file://remote.sh \
	file://remote.pro \
	file://main.cpp \
	file://MyTcpSocket.h \
	file://MyTcpSocket.cpp \
	"

SRCREV = "${AUTOREV}"
S = "${WORKDIR}"
PR = "r0"
DEPENDS = " qtbase"

inherit update-rc.d
inherit qmake5

do_install_append() {
	install -d ${D}${sysconfdir}/init.d/
	install -m 0755 ${WORKDIR}/remote.sh ${D}${sysconfdir}/init.d/remote
}

INITSCRIPT_NAME = "remote"
INITSCRIPT_PARAMS = "start 99 5 . stop 00 0 1 6 ."

#S = "${WORKDIR}"
#PR = "r0"
#DEPENDS = " qtbase"

#inherit qmake5
