#!/bin/bash
if ! diff -u /etc/ntp.conf /etc/ntp.conf.bak; then
echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:"
diff -u /etc/ntp.conf.bak /etc/ntp.conf
cp /etc/ntp.conf.bak /etc/ntp.conf
service ntp restart
 else
if ! pgrep ntp > /dev/null; then
 echo "NOTICE: ntp is not running"
 service ntp restart
fi
fi

