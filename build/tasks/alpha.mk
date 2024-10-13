ALPHA_TARGET_PACKAGE := $(PRODUCT_OUT)/ALPHA-$(ALPHA_VERSION).zip
SHA256 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/sha256sum

.PHONY: otapackage alpha bacon
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
alpha: otapackage
	$(hide) mv $(INTERNAL_OTA_PACKAGE_TARGET) $(ALPHA_TARGET_PACKAGE)
	$(hide) $(SHA256) $(ALPHA_TARGET_PACKAGE) | cut -d ' ' -f1 > $(ALPHA_TARGET_PACKAGE).sha256sum
	$(hide) source ./vendor/alpha/tools/generate_json_build_info.sh $(ALPHA_TARGET_PACKAGE)
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}ALPHA${txtrst}";
	@echo '_______ ______         ______          ________                _____ _________ ' >&2
	@echo '___    |___  /________ ___  /_ ______ ____  __ \______________ ___(_)______  / ' >&2
	@echo '__  /| |__  / ___  __ \__  __ \_  __ `/__  / / /__  ___/_  __ \__  / _  __  /  ' >&2
	@echo '_  ___ |_  /  __  /_/ /_  / / // /_/ / _  /_/ / _  /    / /_/ /_  /  / /_/ /   ' >&2
	@echo '/_/  |_|/_/   _  .___/ /_/ /_/ \__,_/  /_____/  /_/     \____/ /_/   \__,_/    ' >&2
	@echo '              /_/                                                              ' >&2
	@echo '' >&2
	@echo '' >&2
	@echo -e "zip: "$(ALPHA_TARGET_PACKAGE)
	@echo -e "sha256: `cat $(ALPHA_TARGET_PACKAGE).sha256sum | cut -d ' ' -f 1`"
	@echo -e "size: `ls -lah $(ALPHA_TARGET_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""

bacon: alpha
