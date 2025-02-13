# Контейнер Astra Linux с клиентом Basis для запуска в Mac OS ARM

## Подготовка

Скачать по ссылке предоставленной заказчиком дистрибутив Basis Client для Astra Linux 1.7 - `astra1.7.zip`

```bash
$ shasum astra1.7.zip
9ffdb7c184b9d3b210af93fa9857f6d9f4a1b7b3  astra1.7.zip
```

Поменять в файле app-config.template строку `vrm.example.com` на адрес диспетчера подключений заказчика. Поменять строку `region.example.com` на доменное имя для авторизации. И сохранить файл под именем app-config.

```bash
jq '.brokers = ["vrm.example.ru"] | .user_domain = "region.example.ru"' app-config.template > app-config
```

## Сборка контейнера xorg

`docker build --platform linux/amd64 -t astra-vdi:1.7.6 .`

## Сборка контейнера xvfb

Контейнер с xvfb более стбильно работает но с меньшим разрешением экрана.

`docker build --platform linux/amd64 -t astra-vdi:1.7.6-xvfb -f Dockerfile-xvfb .`

## Запуск

`docker run --platform linux/amd64 -d --name vdi -p 5900:5900 astra-vdi:1.7.6 -passwd 12`

## Подключаемся из Mac OS

В Finder нажимаем Cmd+K и в окне Connect to Server пишем адрес `vnc://localhost`. Вводим пароль заданный при запуске параметром `-passwd`.

## Отбражение разрешения экрана в Windows

```PowerShell
Add-Type -Assembly System.Windows.Forms
[Windows.Forms.SystemInformation]::VirtualScreen
```

## Изменение конфигурации без пересборки

`docker run --platform linux/amd64 -d -v $(pwd)/app-config:/root/.vdi-client/app-config --name vdi -p 5900:5900 astra-vdi:1.7.6 -passwd 12`
