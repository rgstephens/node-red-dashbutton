#! /bin/sh
# Starts and stops Dash button monitoring
# Requires node modules: bunyan
# /etc/init.d/dash
### BEGIN INIT INFO
# Provides:     dash
# Required-Start:       $syslog
# Required-Stop:        $syslog
# Default-Start:        2 3 4 5
# Default-Stop:         0 1 6
# Short-Description:    Dash initialisation
### END INIT INFO
# This runs as the user called pi - please change as you require
USER=pi
PROCESS=dash
PROCDIR=/home/pi/.node-red

# The log is written to here - please make sure your user has write permissions.
LOG=/var/log/${PROCESS}.log

#Load up dash when called
case "$1" in

start)
        echo "Starting dash.."
        touch $LOG
        chown $USER:$USER $LOG
        echo "" >> $LOG
        echo "dash service start: "$(date) >> $LOG

        su -l $USER -c "node ${PROCDIR}/${PROCESS}.js ${MQTTPORT} ${WSPORT} | bunyan >> $LOG &"
        echo "Logging to "$LOG
;;

stop)
    echo "Stopping Dash.."

    pkill -SIGINT -f "node ${PROCDIR}/${PROCESS}.js"
    sleep 2
    echo "" >> $LOG
    echo "Dash service stop: "$(date) >> $LOG
;;

restart)
        echo "Restarting Dash.."
        $0 stop
        sleep 2
        $0 start
        echo "Restarted."
;;
*)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
esac