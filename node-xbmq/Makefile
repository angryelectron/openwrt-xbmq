include $(TOPDIR)/rules.mk

PKG_NPM_NAME:=xbmq
PKG_NAME:=node-$(PKG_NPM_NAME)
PKG_VERSION:=2.0.9
PKG_RELEASE:=4

PKG_SOURCE:=$(PKG_NPM_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:=http://registry.npmjs.org/$(PKG_NPM_NAME)/-/
PKG_HASH:=87050680f341c9806c8436e4465441e03ad4c30c58b8b548bdde55d9bad9dc04

PKG_BUILD_DEPENDS:=node/host

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

NODEJS_CPU:=$(subst powerpc,ppc,$(subst aarch64,arm64,$(subst x86_64,x64,$(subst i386,ia32,$(ARCH)))))

define Build/Prepare
	$(INSTALL_DIR) $(PKG_BUILD_DIR)
endef

define Build/Compile
	$(MAKE_VARS) \
	$(MAKE_FLAGS) \
	npm_config_arch=$(NODEJS_CPU) \
	npm_config_nodedir=$(STAGING_DIR)/usr/ \
	npm_config_cache=$(TMP_DIR)/npm-cache \
	npm_config_tmp=$(TMP_DIR)/npm-tmp \
	PREFIX="$(PKG_INSTALL_DIR)/usr/" \
	npm install --production --no-optional --target_arch=$(NODEJS_CPU) -g $(DL_DIR)/$(PKG_SOURCE)
	rm -rf $(TMP_DIR)/npm-tmp
	rm -rf $(TMP_DIR)/npm-cache
endef

define Package/node-xbmq/install
	$(INSTALL_DIR) $(1)/usr/lib/node_modules
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/node_modules/* $(1)/usr/lib/node_modules/
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib/lua/luci $(1)/etc/config $(1)/etc/init.d $(1)/etc/uci-defaults
	$(CP) ./files/luci/* $(1)/usr/lib/lua/luci/ # install luci web-config
	$(INSTALL_CONF) ./files/xbmq.config $(1)/etc/config/xbmq # install default settings
	$(INSTALL_BIN) ./files/xbmq.init $(1)/etc/init.d/xbmq # install init script
	$(INSTALL_BIN) ./files/xbmq-enable.sh $(1)/etc/uci-defaults/99-xbmq-enable # enable on 1st boot
endef

$(eval $(call BuildPackage,node-xbmq))
