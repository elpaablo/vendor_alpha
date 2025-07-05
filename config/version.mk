# Copyright (C) 2020 YAAP
# Copyright (C) 2025 AlphaDroid
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

ALPHA_BUILDTYPE ?= HOMEMADE
ALPHA_BUILD_VERSION := $(PLATFORM_VERSION)
ALPHA_VERSION := $(ALPHA_BUILD_VERSION)-$(ALPHA_BUILDTYPE)-$(TARGET_PRODUCT_SHORT)-$(BUILD_DATE)
ROM_FINGERPRINT := ALPHA/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.alpha.build.version=$(ALPHA_BUILD_VERSION) \
  ro.alpha.build.date=$(BUILD_DATE) \
  ro.alpha.buildtype=$(ALPHA_BUILDTYPE) \
  ro.alpha.fingerprint=$(ROM_FINGERPRINT) \
  ro.alpha.version=$(ALPHA_VERSION) \
  ro.alpha.device=$(ALPHA_BUILD) \
  ro.modversion=$(ALPHA_VERSION)

# Signing
ifneq (eng,$(TARGET_BUILD_VARIANT))
ifneq (,$(wildcard vendor/alpha/signing/keys/releasekey.pk8))
PRODUCT_DEFAULT_DEV_CERTIFICATE := vendor/alpha/signing/keys/releasekey
ifneq ($(TARGET_NO_OEM_UNLOCK),true)
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.oem_unlock_supported=1
endif
endif
ifneq (,$(wildcard vendor/alpha/signing/keys/otakey.x509.pem))
PRODUCT_OTA_PUBLIC_KEYS := vendor/alpha/signing/keys/otakey.x509.pem
endif
endif
