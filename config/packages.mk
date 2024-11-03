
# Apps
PRODUCT_PACKAGES += \
    Backgrounds \
    Eleven \
    Etar \
    ExactCalculator \
    Glimpse \
    Jelly \
    LatinIME \
    LineageParts \
    LineageSettingsProvider \
    LineageSetupWizard \
    Profiles \
    QuickAccessWallet \
    Recorder \
    Seedvault \
    ThemePicker \
    ThemesStub \
    TrebuchetQuickStep \
    Updater

ifneq ($(PRODUCT_NO_CAMERA),true)
PRODUCT_PACKAGES += \
    Aperture
endif

ifneq ($(TARGET_EXCLUDES_AUDIOFX),true)
PRODUCT_PACKAGES += \
    AudioFX
endif

# Extra packages
# PRODUCT_PACKAGES += \
    BatteryStatsViewer \
    GameSpace \
    OmniJaws \
    OmniStyle

# ifneq ($(TARGET_FACE_UNLOCK_SUPPORTED),false)
# ifeq ($(TARGET_SUPPORTS_64_BIT_APPS),true)
# PRODUCT_PACKAGES += \
#     FaceUnlock
#
# PRODUCT_SYSTEM_EXT_PROPERTIES += \
#     ro.face.sense_service=true
#
# PRODUCT_COPY_FILES += \
#     frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.biometrics.face.xml
# endif
# endif

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
    PRODUCT_PACKAGES += \
        DeviceAsWebcam
endif

ifeq ($(TARGET_INCLUDE_MATLOG),true)
  PRODUCT_PACKAGES += \
    MatLog
endif

# Bootanimation
# PRODUCT_PACKAGES += \
#    bootanimation.zip

# Overlays
PRODUCT_PACKAGES += \
    DocumentsUIOverlay \
    NetworkStackOverlay \
    NavigationBarMode2ButtonOverlay

# Build Manifest
PRODUCT_PACKAGES += \
    build-manifest

# Config
PRODUCT_PACKAGES += \
    SimpleDeviceConfig \
    SimpleSettingsConfig

# Root
PRODUCT_PACKAGES += \
    adb_root

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# These packages are excluded from user builds
PRODUCT_PACKAGES_DEBUG += \
    procmem

# Filesystems tools
PRODUCT_PACKAGES += \
    fsck.ntfs \
    mkfs.ntfs \
    mount.ntfs

# Extra tools in Lineage
PRODUCT_PACKAGES += \
    bash \
    curl \
    getcap \
    htop \
    nano \
    setcap \
    vim

# Extra cmdline tools
PRODUCT_PACKAGES += \
    unrar \
    zstd
