#!/bin/sh
#
# Reset the wifi module Axotec IGX-560 using gpio pins
# on the i2c expander pca953x port 500

PORT="500"
GPIO_PORT="/sys/class/gpio/gpio${PORT}"
MSG="Resetting the wifi module on Axotec IGX-560"

case "$1" in
  start)
        ;;
  stop|restart|reload)
    printf "${MSG}:"
    if [ ! -d ${GPIO_PORT} ]; then
      echo ${PORT} > /sys/class/gpio/export
      echo "high" > ${GPIO_PORT}/direction
    fi
    echo 0 > ${GPIO_PORT}/value
    sleep 1
    echo 1 > ${GPIO_PORT}/value
    [ $? = 0 ] && echo "OK" || echo "FAIL"
        ;;
  *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
esac

exit $?