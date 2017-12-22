# OpenWRT/LEDE package for XBMQ

[XBMQ](https://github.com/angryelectron/xbmq-js) is a node.js application that
acts as a gateway between XBee and MQTT.  While it is possible to use npm to install
xbmq, this package handles dependencies, installs a service, integrates with UCI,
and adds a web interface for configuring and controlling xbmq using lUCI.
