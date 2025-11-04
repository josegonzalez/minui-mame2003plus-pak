PAK_NAME := $(shell jq -r .name pak.json)
PAK_TYPE := $(shell jq -r .type pak.json)
PAK_FOLDER := $(shell echo $(PAK_TYPE) | cut -c1)$(shell echo $(PAK_TYPE) | tr '[:upper:]' '[:lower:]' | cut -c2-)s

PUSH_SDCARD_PATH ?= /mnt/SDCARD
PUSH_PLATFORM ?= tg5040

ARCHITECTURES := arm arm64
PLATFORMS := my355 tg5040

CORE_VERSION := aa00b6b187d87a7babf546fa8ec99f89cba81ff4
CORE_NAME := mame2003_plus_libretro.so

clean:
	rm -f $(CORE_NAME) || true

build: $(CORE_NAME)

$(CORE_NAME):
	curl -f -o $(CORE_NAME).zip -sSL "https://github.com/christianhaitian/retroarch-cores/raw/$(CORE_VERSION)/aarch64/$(CORE_NAME).zip"
	unzip $(CORE_NAME).zip
	rm -f $(CORE_NAME).zip

release: build
	mkdir -p dist
	git archive --format=zip --output "dist/$(PAK_NAME).pak.zip" HEAD
	while IFS= read -r file; do zip -r "dist/$(PAK_NAME).pak.zip" "$$file"; done < .gitarchiveinclude
	$(MAKE) bump-version
	zip -r "dist/$(PAK_NAME).pak.zip" pak.json
	ls -lah dist

bump-version:
	jq '.version = "$(RELEASE_VERSION)"' pak.json > pak.json.tmp
	mv pak.json.tmp pak.json

push: release
	rm -rf "dist/$(PAK_NAME).pak"
	cd dist && unzip "$(PAK_NAME).pak.zip" -d "$(PAK_NAME).pak"
	adb push "dist/$(PAK_NAME).pak/." "$(PUSH_SDCARD_PATH)/$(PAK_FOLDER)/$(PUSH_PLATFORM)/$(PAK_NAME).pak"