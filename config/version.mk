# Copyright (C) 2020 YAAP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Versioning System
BUILD_DATE := $(shell date +%Y%m%d)
TARGET_PRODUCT_SHORT := $(subst alpha_,,$(ALPHA_BUILD))

ALPHA_BUILDTYPE ?= Unofficial
ALPHA_BUILD_VERSION := 3.0
ALPHA_BUILD_VARIANT ?= microg
ALPHA_VERSION := $(ALPHA_BUILD_VERSION)-$(ALPHA_VARIANT)-$(TARGET_PRODUCT_SHORT)-$(BUILD_DATE)
ALPHA_DISPLAY_VERSION := AlphaDroid-$(ALPHA_BUILD_VERSION)-$(ALPHA_BUILD_VARIANT)
ALPHA_MAINTAINER ?= buildbot

ROM_FINGERPRINT := ALPHA/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.yaap.build.version=$(ALPHA_BUILD_VERSION) \
  ro.yaap.build.date=$(BUILD_DATE) \
  ro.yaap.buildtype=$(ALPHA_BUILDTYPE) \
  ro.yaap.fingerprint=$(ROM_FINGERPRINT) \
  ro.yaap.version=$(ALPHA_VERSION) \
  ro.yaap.device=$(ALPHA_BUILD) \
  ro.modversion=$(ALPHA_VERSION) \
	ro.alpha.build.version=$(ALPHA_BUILD_VERSION) \
	ro.alpha.build.variant=$(ALPHA_BUILD_VARIANT) \
	ro.alpha.maintainer=$(ALPHA_MAINTAINER) \
	ro.alpha.build.date=$(BUILD_DATE) \
	ro.alpha.buildtype=$(ALPHA_BUILDTYPE) \
	ro.alpha.fingerprint=$(ROM_FINGERPRINT) \
	ro.alpha.version=$(ALPHA_VERSION) \
	ro.alpha.device=$(ALPHA_BUILD) \
	ro.alpha.version=$(ALPHA_VERSION)

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/alpha/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/alpha/signing/keys/releasekey
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
ifneq (,$(wildcard vendor/alpha/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/alpha/signing/keys/otakey.x509.pem
endif
endif
