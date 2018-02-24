#!/bin/sh
### BEGIN INIT INFO
# Provides:		resetnet
# Required-Start:	$remote_fs $syslog
# Required-Stop:
# Default-Start:	5
# Default-Stop:
# Short-Description:	Loop until connection with MASTER_SE is set
### END INIT INFO

LED='/sys/class/gpio/gpio14/value'
OFF='/sys/class/gpio/gpio2/value'

ledtwinkle() {
	while [ true ]
		do
		echo '1' > ${LED}
		sleep 0.2s
		echo '0' > ${LED}
		sleep 0.2s
		done ; }

powerbutton() {
	while [ true ]
		do
		[ "$(cat ${OFF})" = '0' ] && poweroff
		sleep 0.5s
		done ; }

case "$1" in
	start)
		powerbutton & powerbuttonPID=$!
		echo '0' > ${LED}

		while [ -z "$(ifconfig wlan0 | grep -w 'inet')" ]
			do
			echo 'Connection failed'
			sleep 1s
			ledtwinkle & ledtwinklePID=$!
			ifdown wlan0
			sleep 1s
			echo 'Try to touch MASTER_SE network...'
			ifup wlan0
			kill ${ledtwinklePID}
			echo '0' > ${LED}
			done

		echo '1' > ${LED}
		echo 'Connection to MASTER_SE : DONE'
		kill ${powerbuttonPID}
		;;
	*)
		echo "$0 isn't a daemon"
		echo "Usage : $0 {start}"
		;;
	esac
exit 0
