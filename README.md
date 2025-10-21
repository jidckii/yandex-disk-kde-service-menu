# Yandex.Disk KDE Service Menu

![](img/preview.png)

![](img/preview_publish.png)
![](img/preview_unpublish.png)

---

Service menu, который позволяет получить быстрый доступ к сервису Яндекс.Диск

## Возможности

- Опубликовать файл/каталог и скопировать публичную ссылку буфер обмена
- Снять с публикации файл/каталог

При публикации файла/каталога вне директории диска, объект будет скопирован в корень диска и опубликован, это стандартное поведение самой утилиты yandex-disk.

```sh
publish    make file/folder public, output public link to STDOUT.
            Object will be copied to the root of sync folder.
            To overwrite existing objects use
            the option --overwrite.
```

## Зависимости

- Консольный клиент для Linux - http://help.yandex.ru/disk/cli-clients.xml  
    - **ALT Linux** - https://www.altlinux.org/%D0%AF%D0%BD%D0%B4%D0%B5%D0%BA%D1%81_%D0%94%D0%B8%D1%81%D0%BA)  
    - **Arch Linux** - https://aur.archlinux.org/packages/yandex-disk/)  

- libnotify
- kdialog
- xsel
