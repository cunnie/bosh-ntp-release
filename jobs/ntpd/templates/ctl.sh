#!/bin/bash

RUN_DIR=/var/vcap/sys/run/ntpd
# PID_FILE is created by named, not by this script
PID_FILE=${RUN_DIR}/ntpd.pid
# ntpd is on stemcell by default

case $1 in

  start)
    mkdir -p $RUN_DIR
    chown -R vcap:vcap $RUN_DIR
    exec /usr/sbin/ntpd -u vcap:vcap -p $PID_FILE -c /var/vcap/packages/ntpd/etc/ntp.conf
    ;;

  stop)
    PID=$(cat $PID_FILE)
    kill -TERM $PID
    sleep 1
    kill -KILL $PID

    rm -rf $PID_FILE
    ;;

  *)
    echo "Usage: ctl {start|stop}" ;;

esac