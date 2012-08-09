#!/bin/sh
#
# control script for goagent-local
#
start() {
    cd $(dirname "$0")
    export PYTHONHOME=../python
    ../python/bin/python goagent-daemon.py &
    touch /tmp/goagent.pid
}
stop() {
    killall python
    rm -f /tmp/goagent.pid
}
# See how we were called.
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac
exit $?

