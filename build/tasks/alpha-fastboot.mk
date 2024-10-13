ALPHA_FASTBOOT_PACKAGE := $(PRODUCT_OUT)/ALPHA-$(ALPHA_VERSION)-img.zip

.PHONY: updatepackage yaap-fastboot
updatepackage: $(INTERNAL_UPDATE_PACKAGE_TARGET)
yaap-fastboot: updatepackage
	$(hide) mv $(INTERNAL_UPDATE_PACKAGE_TARGET) $(ALPHA_FASTBOOT_PACKAGE)
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}ALPHA${txtrst}";
	@echo '_______ ______         ______          ________                _____ _________ ' >&2
	@echo '___    |___  /________ ___  /_ ______ ____  __ \______________ ___(_)______  / ' >&2
	@echo '__  /| |__  / ___  __ \__  __ \_  __ `/__  / / /__  ___/_  __ \__  / _  __  /  ' >&2
	@echo '_  ___ |_  /  __  /_/ /_  / / // /_/ / _  /_/ / _  /    / /_/ /_  /  / /_/ /   ' >&2
	@echo '/_/  |_|/_/   _  .___/ /_/ /_/ \__,_/  /_____/  /_/     \____/ /_/   \__,_/    ' >&2
	@echo '              /_/                                                              ' >&2
	@echo '' >&2
	@echo -e "zip: "$(ALPHA_FASTBOOT_PACKAGE)
	@echo -e "size: `ls -lah $(ALPHA_FASTBOOT_PACKAGE) | cut -d ' ' -f 5`"
	@echo -e ""
