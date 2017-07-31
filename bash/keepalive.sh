#!/bin/bash
## Keep traffic moving

TARGET="8.8.8.8"

while true; do
        date
        /bin/ping -c1 $TARGET | /bin/egrep "bytes from"
        sleep $1
done
