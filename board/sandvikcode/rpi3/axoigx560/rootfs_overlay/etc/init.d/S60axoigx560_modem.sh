#!/bin/sh
#
# Enable/disable 4G modem on Axotec IGX-560 using gpio pins
# on the i2c expander pca953x port 509

PORT="509"
GPIO_PORT="/sys/class/gpio/gpio${PORT}"
MSG="4G modem Simtech Sim7100 on Axotec IGX-560"

case "$1" in
  start)
        printf "Enabling ${MSG}:"
        if [ ! -d ${GPIO_PORT} ]; then
            echo ${PORT} > /sys/class/gpio/export
            echo "low" > ${GPIO_PORT}/direction
        fi
        echo 1 > ${GPIO_PORT}/value
        [ $? = 0 ] && echo "OK" || echo "FAIL"
        ;;
  stop)
        printf "Disabling ${MSG}: "
        if [ ! -d ${GPIO_PORT} ]; then
            printf "Already disabled"
        else
            echo 0 > ${GPIO_PORT}/value
            [ $? = 0 ] && echo "OK" || echo "FAIL"
        fi
        ;;
  restart|reload)
        "$0" stop
        "$0" start
        ;;
  *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
esac

exit $?