IMAGE_NAME := civetweb
IMAGE_TAG := latest

LATEST_CIVETWEB_VERSION := $(shell scripts/get-latest-release-tag.sh civetweb civetweb | tr -d 'v')

image:
	docker build --pull -t "$(IMAGE_NAME):$(IMAGE_TAG)" \
	             --build-arg CIVETWEB_VERSION="$(LATEST_CIVETWEB_VERSION)" \
	             . 2>&1 | tee build.log

latest-version-info:
	@echo "CivetWeb: $(LATEST_CIVETWEB_VERSION)"

.PHONY: image latest-version-info
