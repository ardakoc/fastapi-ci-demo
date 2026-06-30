#!/bin/bash

case "$1" in
  start)
    docker compose up -d
    ;;
  stop)
    docker compose down
    ;;
  status)
    docker compose ps
    ;;
  *)
    echo "Usage: ./manage.sh {start|stop|status}"
    ;;
esac