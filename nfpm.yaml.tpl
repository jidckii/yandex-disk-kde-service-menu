name: "yandex-disk-kde-service-menu"
arch: "all"
platform: "linux"
version: ${VERSION}
release: 1
section: "utils"
priority: "optional"
maintainer: Evgeniy Medvedev <jidckii@gmail.com>"
description: |
  KDE Service Menu for Yandex.Disk
  Provides integration with Yandex.Disk in KDE file manager Dolphin.
vendor: "Evgeniy Medvedev"
homepage: "https://github.com/jidckii/yandex-disk-kde-service-menu"
license: "MIT"

contents:
  - src: yandex-disk-kde-service-menu.desktop
    dst: /usr/share/kio/servicemenus/
    file_info:
      mode: 0755
  - src: yd-sm.sh
    dst: /usr/bin/
    file_info:
      mode: 0755

scripts:
  postinstall: "nfpm/scripts/postinstall.sh"

depends:
  - libnotify
  - kdialog
  - xsel

deb:
  signature:
    key_file: ${GPG_KEY_FILE}
    key_id: ${GPG_KEY_ID}
rpm:
  signature:
    key_file: ${GPG_KEY_FILE}
    key_id: ${GPG_KEY_ID}
