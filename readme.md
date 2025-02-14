# Контейнер Astra Linux с клиентом Basis для запуска в Mac OS ARM

Используется запущенный на Mac OS контейнер Docker с подключением через RDP.

## Подготовка

Скачать по ссылке предоставленной заказчиком дистрибутив Basis Client для Astra Linux 1.7 - `astra1.7.zip`

```bash
$ shasum astra1.7.zip
9ffdb7c184b9d3b210af93fa9857f6d9f4a1b7b3  astra1.7.zip
```

## Сборка контейнера

`docker build --platform linux/amd64 -t astra-vdi:1.7.6 .`

## Запуск

`docker run --platform linux/amd64 -d --name vdi -p 3389:3389 astra-vdi:1.7.6`

## Подключаемся из Mac OS

Из App Store ставим клиента RDP для Mac OS https://apps.apple.com/ru/app/windows-app/id1295203466?l=en-GB&mt=12

В приложении Windows App добавяем App PC:

* PC Name: localhost
* Credentials: Add credentials
* Username: user
* Password: user

## Отбражение разрешения экрана в Windows

```PowerShell
Add-Type -Assembly System.Windows.Forms
[Windows.Forms.SystemInformation]::VirtualScreen
```
