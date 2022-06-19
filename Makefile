include $(TOPDIR)/rules.mk

PKG_NAME:=rtl8821cu
PKG_VERSION:=2022-05-30
PKG_RELEASE=$(PKG_SOURCE_VERSION)

PKG_LICENSE:=GPLv2
PKG_LICENSE_FILES:=

PKG_SOURCE_URL:=https://github.com/brektrou/rtl8821CU.git
PKG_MIRROR_HASH:=0252d56e34cb8d17a1d2584d36030f539bd31771d60fffb27193c763ecf69e1c
PKG_SOURCE_PROTO:=git
PKG_SOURCE_DATE:=2022-06-19
PKG_SOURCE_VERSION:=8c2226a74ae718439d56248bd2e44ccf717086d5

PKG_MAINTAINER:=brektrou
PKG_BUILD_PARALLEL:=1
#PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)-$(PKG_VERSION)
#PKG_EXTMOD_SUBDIRS:=$(PKG_NAME)

STAMP_CONFIGURED_DEPENDS := $(STAGING_DIR)/usr/include/mac80211-backport/backport/autoconf.h

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/package.mk

define KernelPackage/$(PKG_NAME)
  SUBMENU:=Wireless Drivers
  TITLE:=Driver for Realtek 8821CU
  DEPENDS:=+kmod-cfg80211 +kmod-usb-core +usb-modeswitch +@DRIVER_11N_SUPPORT +@DRIVER_11AC_SUPPORT
  FILES:=\
	$(PKG_BUILD_DIR)/rtl8821cu.ko
  AUTOLOAD:=$(call AutoProbe,rtl8821cu)
  PROVIDES:=kmod-rtl8821cu
endef

NOSTDINC_FLAGS := \
	$(KERNEL_NOSTDINC_FLAGS) \
	-I$(PKG_BUILD_DIR) \
	-I$(PKG_BUILD_DIR)/include \
	-I$(STAGING_DIR)/usr/include/mac80211-backport \
	-I$(STAGING_DIR)/usr/include/mac80211-backport/uapi \
	-I$(STAGING_DIR)/usr/include/mac80211 \
	-I$(STAGING_DIR)/usr/include/mac80211/uapi \
	-include backport/backport.h

NOSTDINC_FLAGS+=-DCONFIG_IOCTL_CFG80211 -DRTW_USE_CFG80211_STA_EVENT -DBUILD_OPENWRT

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C "$(LINUX_DIR)" \
		$(KERNEL_MAKE_FLAGS) \
		M="$(PKG_BUILD_DIR)" \
		NOSTDINC_FLAGS="$(NOSTDINC_FLAGS)" \
		MODULE_NAME="$(PKG_NAME)"
endef

$(eval $(call KernelPackage,$(PKG_NAME)))
