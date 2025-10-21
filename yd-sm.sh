#!/bin/bash

set -u

YD_ERROR="yandex-disk не установлен!

Инструкция по установке:
https://yandex.ru/support/yandex-360/customers/disk/desktop/linux/ru/

После установки авторизуйтесь:
yandex-disk setup

В ALT Linux также можно сразу установить сервис для автозапуска:
sudo apt-get update -qq
sudo apt-get install yandex-disk-indicator
systemctl --user enable --now yandex-disk
"

if ! command -v yandex-disk &> /dev/null; then
    kdialog --title "Ошибка" --error "$YD_ERROR"
    exit 1
fi

publish() {
    RESULT=$(yandex-disk publish "$1" 2>&1)

    if [ $? -ne 0 ]; then
        kdialog --title "Ошибка" --error "Не удалось опубликовать файл:\n\n$RESULT"
    fi

    if echo "$RESULT" | grep -q "http"; then
        echo "$RESULT" | xclip -selection clipboard
        kdialog --title "Яндекс.Диск" --passivepopup "Ссылка скопирована в буфер обмена:\n$RESULT" 5
    else
        kdialog --title "Ошибка публикации" --error "Не удалось опубликовать файл:\n\n$RESULT"
    fi
}

unpublish() {
    RESULT=$(yandex-disk unpublish "$1" 2>&1)
    if [ $? -eq 0 ]; then
        kdialog --title "Яндекс.Диск" --passivepopup "Файл снят с публикации" 3
    else
        kdialog --title "Ошибка" --error "Не удалось снять файл с публикации:\n\n$RESULT"
    fi
}

if [ $# -ne 2 ]; then
    kdialog --title "Ошибка" --error "Неверное количество аргументов"
    exit 1
fi

if [ ! -e "$2" ]; then
    kdialog --title "Ошибка" --error "Файл или каталог не существует: $2"
    exit 1
fi

case "$1" in
    publish)
        publish "$2"
        ;;
    unpublish)
        unpublish "$2"
        ;;
    *)
        kdialog --title "Ошибка" --error "Неизвестное действие: $1"
        exit 1
        ;;
esac
