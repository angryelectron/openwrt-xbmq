#!/bin/sh
/etc/init.d/xbmq enable # enable the service

## Let UCI restart the service in response to config changes
/sbin/uci add ucitrack xbmq
/sbin/uci add ucitrack xbmq
/sbin/uci set ucitrack.@xbmq[0].init=xbmq
/sbin/uci commit
