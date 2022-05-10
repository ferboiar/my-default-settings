#
# Copyright (C) 2010-2022 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=my-default-settings
PKG_VERSION:=2
PKG_RELEASE:=50
PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  TITLE:=LuCI support for Default Settings
  MAINTAINER:=ferboiar
  PKGARCH:=all
  DEPENDS:=+luci-base +luci +bash
endef

define Package/default-settings/description
	Language Support Packages.
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/
/etc/nginx/
endef

define Build/Prepare
	chmod -R +x ./files/bin ./files/sbin ./files/etc/profile.d ./files/etc/rc.d ./files/etc/init.d ./files/usr/share target/*/{*,}/files/{etc/init.d,usr/bin} >/dev/null || true
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(CP) ./files/* $(1)/
	echo $(BOARD)$(TARGETID)
	if [ -d ./target/$(BOARD)/files/. ]; then \
		$(CP) ./target/$(BOARD)/files/* $(1)/; \
	fi
	if [ -d ./target/$(TARGETID)/files/. ]; then \
		$(CP) ./target/$(TARGETID)/files/* $(1)/; \
	fi
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
