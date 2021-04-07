# OpenWrt XBMQ Package

Add this feed to `feeds.conf` or `feeds.conf.default` in your OpenWRT
[build environment](https://wiki.openwrt.org/doc/howto/build) to enable
[XBMQ](https://github.com/angryelectron/xbmq-js), an XBee-MQTT gateway, to your
router.

```
src-git xbmq http://github.com/angryelectron/openwrt-xbmq
```

Then update your feeds and install the new package(s):

```
./scripts/feeds update xbmq
./scripts/feeds install -a xbmq
```

Packages in this feed have dependencies on `node` and `node-serialport`.  It is
recommended to use the [nxhack/openwrt-node-packages](https://github.com/nxhack/openwrt-node-packages)
instead of the packages in the default `packages` feed.  See the nxhack README
for more details on how to override the default packages.
