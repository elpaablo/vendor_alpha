# Allow vendor/extra to override any property by setting it first
$(call inherit-product-if-exists, vendor/extra/product.mk)
$(call inherit-product-if-exists, vendor/addons/config.mk)
$(call inherit-product, vendor/alpha/config/properties.mk)
$(call inherit-product, vendor/alpha/config/packages.mk)
$(call inherit-product, vendor/alpha/config/audio.mk)

PRODUCT_BRAND ?= AlphaDroid
TARGET_SCREEN_WIDTH ?= 1080
TARGET_SCREEN_HEIGHT ?= 1920

# Do not include art debug targets
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# Speed profile services and wifi-service to reduce RAM and storage
PRODUCT_SYSTEM_SERVER_COMPILER_FILTER := speed-profile
PRODUCT_USE_PROFILE_FOR_BOOT_IMAGE := true
PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION := frameworks/base/config/boot-image-profile.txt

PRODUCT_SYSTEM_SERVER_DEBUG_INFO := false
WITH_DEXPREOPT_DEBUG_INFO := false

# Strip the local variable table and the local variable type table to reduce
# the size of the system image. This has no bearing on stack traces, but will
# leave less information available via JDWP.
PRODUCT_MINIMIZE_JAVA_DEBUG_INFO := true

# Enable whole-program R8 Java optimizations for SystemUI and system_server,
# but also allow explicit overriding for testing and development.
SYSTEM_OPTIMIZE_JAVA ?= true
SYSTEMUI_OPTIMIZE_JAVA ?= true

# Disable vendor restrictions
PRODUCT_RESTRICT_VENDOR_FILES := false

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/alpha/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/alpha/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/alpha/prebuilt/common/bin/50-alpha.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-alpha.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-alpha.sh

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
  PRODUCT_COPY_FILES += \
    vendor/alpha/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/alpha/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/alpha/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

  PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh
endif

# Updater
PRODUCT_COPY_FILES += \
    vendor/alpha/prebuilt/common/etc/init/init.alpha-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.alpha-updater.rc

# Boadcast actions whitelist
PRODUCT_COPY_FILES += \
    vendor/alpha/config/permissions/lineage-sysconfig.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/sysconfig/lineage-sysconfig.xml

# Init rc files
PRODUCT_COPY_FILES += \
    vendor/alpha/prebuilt/common/etc/init/init.alpha-system_ext.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.alpha-system_ext.rc

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.software.sip.voip.xml

# Enable wireless Xbox 360 controller support
PRODUCT_COPY_FILES += \
    frameworks/base/data/keyboards/Vendor_045e_Product_028e.kl:$(TARGET_COPY_OUT_PRODUCT)/usr/keylayout/Vendor_045e_Product_0719.kl

# Permissions
PRODUCT_COPY_FILES += \
    vendor/alpha/config/permissions/org.lineageos.android.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/org.lineageos.android.xml

ifneq ($(TARGET_DISABLE_LINEAGE_SDK), true)
  # Lineage SDK
  include vendor/alpha/config/lineage_sdk_common.mk
endif

PRODUCT_COPY_FILES += \
  vendor/alpha/prebuilt/common/etc/init/init.alpha-updater.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/init.alpha-updater.rc

# OpenSSH
PRODUCT_COPY_FILES += \
    vendor/alpha/prebuilt/common/etc/init/init.openssh.rc:$(TARGET_COPY_OUT_PRODUCT)/etc/init/init.openssh.rc

ifeq ($(TARGET_ENABLE_EPPE),true)
  # Require all requested packages to exist
  $(call enforce-product-packages-exist-internal,$(wildcard device/*/$(LINEAGE_BUILD)/$(TARGET_PRODUCT).mk),product_manifest.xml rild Calendar Launcher3 Launcher3Go Launcher3QuickStep Launcher3QuickStepGo android.hidl.memory@1.0-impl.vendor vndk_apex_snapshot_package)
endif

# TARGET_BUILD_PACKAGE options:
# 1 - vanilla (default)
# 2 - microg
# 3 - gapps
ifeq ($(TARGET_BUILD_PACKAGE),3)
  BUILD_GMS_OVERLAYS_AND_PROPS := true
  $(call inherit-product, vendor/gms/products/gms.mk)
else
  ifeq ($(TARGET_BUILD_PACKAGE),2)
    $(call inherit-product, vendor/microg/product.mk)
  endif
endif

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/curl \
    system/bin/getcap \
    system/bin/setcap

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/fsck.ntfs \
    system/bin/mkfs.ntfs \
    system/bin/mount.ntfs \
    system/%/libfuse-lite.so \
    system/%/libntfs-3g.so

ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/procmem
endif

# SystemUI
PRODUCT_DEXPREOPT_SPEED_APPS += \
    Launcher3QuickStep \
    Lawnchair \
    Settings \
    SystemUI

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/alpha/overlay/no-rro
PRODUCT_PACKAGE_OVERLAYS += \
    vendor/alpha/overlay/common \
    vendor/alpha/overlay/no-rro

# Include LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/alpha/overlay/dictionaries
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/alpha/overlay/dictionaries

PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += vendor/crowdin/overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/crowdin/overlay

# Translations
CUSTOM_LOCALES += \
    ast_ES \
    gd_GB \
    cy_GB \
    fur_IT

PRODUCT_EXTRA_RECOVERY_KEYS += \
    vendor/alpha/build/target/product/security/lineage

include vendor/alpha/config/version.mk
-include $(WORKSPACE)/build_env/image-auto-bits.mk
