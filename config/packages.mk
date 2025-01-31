
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
    OmniJaws \
    Profiles \
    QuickAccessWallet \
    Recorder \
    Seedvault \
    ThemePicker \
    ThemesStub \
    Launcher3QuickStep \
    Updater

ifneq ($(PRODUCT_NO_CAMERA),true)
  PRODUCT_PACKAGES += \
    Aperture
endif

ifneq ($(TARGET_EXCLUDES_AUDIOFX),true)
  PRODUCT_PACKAGES += \
    AudioFX
endif

ifeq ($(TARGET_INCLUDE_MATLOG),true)
  PRODUCT_PACKAGES += \
    MatLog
endif

# Extra packages
# PRODUCT_PACKAGES += \
    BatteryStatsViewer \
    GameSpace \
    OmniStyle

# Bootanimation
PRODUCT_PACKAGES += \
    bootanimation.zip

# Overlays
PRODUCT_PACKAGES += \
    DocumentsUIOverlay \
    NetworkStackOverlay \
    NavigationBarMode2ButtonOverlay \
    WallpaperPickerOverlayAndroid \
    WallpaperPickerOverlaySettings

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
