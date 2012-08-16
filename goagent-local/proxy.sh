#!/bin/sh
#
# control script for goagent-local
#
DBGLOG=/tmp/goagent.log
start() {
    touch /tmp/goagent.pid
    cd "$(dirname "$0")"
    export PYTHONHOME=../python
    ../python/bin/python proxy.py >$DBGLOG  2>$DBGLOG &
}
stop() {
    killall python > /dev/null 2>/dev/null
    rm -rf /tmp/goagent.pid
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

