#!/bin/sh
### BEGIN INIT INFO
# Provides:		helloworld
# Required-Start:	$remote_fs $syslog
# Required-Stop:	$remote_fs $syslog
# Default-Start:	5
# Default-Stop:		0 1 6
# Short-Description:	Helloworld test
## END INIT INFO

NAME='helloworld'
DESC='Test program'
DAEMON='/usr/bin/helloworld'

case "$1" in
	start)
		echo -n "Starting ${DESC} : ${NAME}... "
#		start-stop-daemon -S -b -C -q -x ${DAEMON} > /dev/tty3
		${DAEMON} > /dev/tty3 &
		echo "Done"
		;;
	stop)
		echo -n "Stopping ${DESC} : ${NAME}... "
		start-stop-daemon -K -q -x ${DAEMON}
		echo "Done"
		;;
	restart)
		$0 stop
		$0 start
		;;
	status)
		start-stop-daemon -T -q -x ${DAEMON}
		case "$?" in
			0)
				echo "Le programme ${NAME} est en cours d'exécution."
				;;
			1)
				echo "Le programme ${NAME} n'est pas en cours d'exécution et le fichier PID existe."
				;;
			3)
				echo "Le programme ${NAME} n'est pas en cours d'exécution."
				;;
			4)
				echo "Impossible de déterminer l'état du programme ${NAME}."
				;;
			esac
		;;
	*)
		echo "Usage : $0 {start|stop|restart|status}"
		exit 1
		;;
	esac
exit 0
