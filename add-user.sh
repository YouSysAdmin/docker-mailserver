#!/usr/bin/env bash

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: ${0} <username@domain> <password>"
  exit 1
fi

docker compose exec -ti mailserver setup email add "${1}" "${2}"