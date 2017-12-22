include $(TOPDIR)/rules.mk

PKG_NPM_NAME:=xbmq
PKG_NAME:=node-$(PKG_NPM_NAME)
PKG_VERSION:=2.0.0
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NPM_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://registry.npmjs.org/$(PKG_NPM_NAME)/-/
PKG_HASH:=38c203164e2912cdf8b52318130d29b7

PKG_BUILD_DEPENDS:=node/host
PKG_NODE_VERSION:=6.11.2

include $(INCLUDE_DIR)/package.mk

define Package/node-xbmq
  SUBMENU:=Node.js
	SECTION:=Languages
	CATEGORY:=Languages
	TITLE:=XBee to MQTT gateway
	URL:=https://www.npmjs.org/package/xbmq
	DEPENDS:=+node +node-serialport +node-forever
	MAINTAINER:=Andrew Bythell <abythell@ieee.org>
endef

define Package/node-xbmq/description
  An XBee / MQTT gateway for Node.js
endef

define Build/Prepare
  /bin/tar xzf $(DL_DIR)/$(PKG_SOURCE) -C $(PKG_BUILD_DIR) --strip-components 1 --warning=none
	$(Build/Patch)
endef

define Build/Compile
  $(MAKE_FLAGS) \
	npm_config_arch=$(CONFIG_ARCH) \
	npm_config_nodedir=$(BUILD_DIR)/node-v$(PKG_NODE_VERSION)/ \
	npm_config_cache=$(BUILD_DIR)/node-v$(PKG_NODE_VERSION)/npm-cache \
	PREFIX="$(PKG_INSTALL_DIR)/usr/" \
	npm install -g $(PKG_BUILD_DIR)
endef

define Package/node-xbmq/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib/node_modules $(1)/usr/lib/lua/luci $(1)/etc/config $(1)/etc/init.d $(1)/etc/uci-defaults
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/node_modules/* $(1)/usr/lib/node_modules # copy node scripts
	$(CP) $(PKG_INSTALL_DIR)/usr/bin/* $(1)/usr/bin # install global binary
	$(CP) ./files/luci/* $(1)/usr/lib/lua/luci # install luci web-config
	$(INSTALL_CONF) ./files/xbmq.config $(1)/etc/config/xbmq # install default settings
	$(INSTALL_BIN) ./files/xbmq.init $(1)/etc/init.d/xbmq # install init script
	$(INSTALL_BIN) ./files/xbmq-enable.sh $(1)/etc/uci-defaults/99-xbmq-enable # enable on 1st boot
endef

$(eval $(call BuildPackage,node-xbmq))
