# Работа в синем банке с линукс
В синем банке не любят линукс и используеют ужасные решения checkpoint и basis

# Images creating

## Подготовка
Скачать по ссылке предоставленной заказчиком дистрибутив Basis Client для Astra Linux 1.7 - `astra1.7.zip`
Положить в директорию

## Build base Astra image with neccessery dependencies
```podman build --platform linux/amd64 -t astra-base:1.0 -f Dockerfile.base .```

## Build checkpoint image
```podman build --platform linux/amd64 -t vpn:1.0 -f Dockerfile.vpn .```

## Build basis image
```podman build --platform linux/amd64 -t vdi:1.0 -f Dockerfile.vdi .```

# Run

## Create pod
```podman pod create --name VTB -h vtb -p 3389:3389 #--network host```

## Run vpn in pod
* pcscd должен быть установлен на локалхосте

```podman run --pod=VTB --cap-add=ALL --platform linux/amd64 -d --name vpn -e DISPLAY=$DISPLAY --privileged -v /var/run/pcscd:/var/run/pcscd -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix vpn:1.0```

## Run basis in pod
```podman run --pod=VTB --cap-add=ALL --platform linux/amd64 -d --name vdi -e DISPLAY=$DISPLAY --privileged -v /var/run/pcscd:/var/run/pcscd -v /dev/bus/usb:/dev/bus/usb -v /tmp/.X11-unix:/tmp/.X11-unix vdi:1.0```

### Полезные команды
```podman pod start VTB```
```podman start vdi```

### Можно в remmina подключиться к rdp
* PC Name: localhost
* Credentials: Add credentials
* Username: user
* Password: user
