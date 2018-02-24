#!/bin/sh
### BEGIN INIT INFO
# Provides:				init-gpio
# Required-Start:		$remote_fs $syslog
# Required-Stop:
# Default-Start:		5
# Default-Stop:			0 1 6
# Short-Description:	GPIO initialization for remote shield
### END INIT INFO

case "$1" in
	start)
		echo -n 'Setting GPIO... '
		echo '2' >/sys/class/gpio/export
		echo '3' >/sys/class/gpio/export
		echo '4' >/sys/class/gpio/export
		echo '14' >/sys/class/gpio/export
		echo '17' >/sys/class/gpio/export
		echo '22' >/sys/class/gpio/export
		echo '23' >/sys/class/gpio/export
		echo '27' >/sys/class/gpio/export

		echo 'in' >/sys/class/gpio/gpio2/direction
		echo 'in' >/sys/class/gpio/gpio3/direction
		echo 'in' >/sys/class/gpio/gpio4/direction
		echo 'in' >/sys/class/gpio/gpio17/direction
		echo 'in' >/sys/class/gpio/gpio22/direction
		echo 'in' >/sys/class/gpio/gpio23/direction
		echo 'in' >/sys/class/gpio/gpio27/direction
		echo 'out' >/sys/class/gpio/gpio14/direction
		echo 'Done'
		;;
	stop)
		echo -n 'Unsetting GPIO... '
		echo '2' >/sys/class/gpio/unexport
		echo '3' >/sys/class/gpio/unexport
		echo '4' >/sys/class/gpio/unexport
		echo '14' >/sys/class/gpio/unexport
		echo '17' >/sys/class/gpio/unexport
		echo '22' >/sys/class/gpio/unexport
		echo '23' >/sys/class/gpio/unexport
		echo '27' >/sys/class/gpio/unexport
		echo 'Done'
		;;
	restart)
		$0 stop
		$0 start
		;;
	*)
		echo "Usage : $0 {start|stop|restart}"
		;;
esac
exit 0
