PRODUCT_VERSION_MAJOR = 3
PRODUCT_VERSION_MINOR = 1

ALPHA_VERSION_NAME := AlphaDroid
ALPHA_VERSION_CODENAME := a$(PLATFORM_VERSION)
ALPHA_BUILD_VERSION := 3.1
ALPHA_BUILD_VARIANT := vanilla
ALPHA_RELEASE_TYPE ?= unofficial
ALPHA_MAINTAINER ?= buildbot

ifeq ($(ALPHA_VERSION_APPEND_TIME_OF_DAY),true)
    ALPHA_BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
    ALPHA_BUILD_DATE := $(shell date -u +%Y%m%d)
endif

# Only include Updater for official builds
ifeq ($(filter-out OFFICIAL Official official,$(ALPHA_BUILD_TYPE)),)
  ALPHA_RELEASE_TYPE := $(ALPHA_BUILD_TYPE)
  -include vendor/alpha-priv/keys/keys.mk
endif

# TARGET_BUILD_PACKAGE options:
# 1 - vanilla (default)
# 2 - microg
# 3 - gapps
ifeq ($(TARGET_BUILD_PACKAGE),3)
  ALPHA_BUILD_VARIANT := gapps
  $(call inherit-product, vendor/gms/products/gms.mk)
else
  ifeq ($(TARGET_BUILD_PACKAGE),2)
    ALPHA_BUILD_VARIANT := microg
    $(call inherit-product, vendor/microg/product.mk)
  endif
endif

# Internal version
ALPHA_VERSION := $(ALPHA_VERSION_NAME)-v$(ALPHA_BUILD_VERSION)-$(ALPHA_BUILD_VARIANT)-$(ALPHA_BUILD_DATE)

# Display version
ALPHA_DISPLAY_VERSION := $(ALPHA_VERSION_NAME)-$(ALPHA_BUILD_VERSION)-$(ALPHA_BUILD_VARIANT)

PRODUCT_SYSTEM_PROPERTIES += \
    ro.alpha.version=$(ALPHA_VERSION) \
    ro.alpha.release.type=$(ALPHA_RELEASE_TYPE) \
    ro.alpha.build.version=$(ALPHA_BUILD_VERSION) \
    ro.alpha.maintainer=$(ALPHA_MAINTAINER) \
    ro.alpha.build.variant=$(ALPHA_BUILD_VARIANT) \
    ro.lineage.build.version=$(ALPHA_BUILD_VERSION)
