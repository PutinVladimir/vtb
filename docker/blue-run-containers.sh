#!/bin/bash

COMPOSE_FILE="docker-compose.yml"

function usage {
  echo "Usage: $0 {start|stop|restart|status}"
  exit 1
}

function start {
  echo "🔧 Разрешаем доступ к X-серверу для Docker..."
  xhost +local:docker

  echo "🚀 Запускаем контейнеры vpn и vdi..."
  docker compose -f "$COMPOSE_FILE" up -d
}

function stop {
  echo "🛑 Останавливаем контейнеры vpn и vdi..."
  docker compose -f "$COMPOSE_FILE" down
}

function restart {
  stop
  start
}

function status {
  docker ps --filter "name=vpn" --filter "name=vdi"
}

case "$1" in
  start) start ;;
  stop) stop ;;
  restart) restart ;;
  status) status ;;
  *) usage ;;
esac

