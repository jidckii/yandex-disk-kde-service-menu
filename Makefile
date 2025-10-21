## This is a self-documented Makefile
## ref: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

VERSION := 1.0.0

.DEFAULT_GOAL := build
.PHONY: build clean publish

clean: ## Очистить папку сборки
	rm -rf dist

build: dist/.build-stamp ## Собрать пакет

dist/.build-stamp: yandex-disk-kde-service-menu.desktop yd-sm.sh $(wildcard nfpm/scripts/*) nfpm.yaml.tpl
	mkdir -p dist
	VERSION=$(VERSION) envsubst '$${VERSION}' <nfpm.yaml.tpl >nfpm.yaml
	nfpm package --config nfpm.yaml --packager deb --target dist
	nfpm package --config nfpm.yaml --packager rpm --target dist
	nfpm package --config nfpm.yaml --packager archlinux --target dist
	touch dist/.build-stamp

publish:
	@echo "Publishing packages..."
	./publish.sh
