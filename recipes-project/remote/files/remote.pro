#-------------------------------------------------
#
# Project created by QtCreator 2018-01-31T09:10:03
#
#-------------------------------------------------

QT       += core network

QT       -= gui

TARGET = remote
CONFIG   += console
CONFIG   -= app_bundle
INCLUDEPATH += .

TEMPLATE = app


SOURCES += main.cpp \
    MyTcpSocket.cpp

HEADERS += \
    MyTcpSocket.h

target.path = /usr/bin
INSTALLS += target
