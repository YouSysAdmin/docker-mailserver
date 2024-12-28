#!/usr/bin/env bash

data_dir="./data"
services=("mailserver" "roundcube" "traefik")

if [ ! -f .env ]; then
  echo "ERROR: .env file not found"
  exit 1
fi

function prepare_dir() {
  local dirs=("acme" "mailserver/config" "mailserver/config/ssl" "mailserver/data" "mailserver/logs" "mailserver/state" "roundcube/db" "roundcube/www" "traefik/logs")
  for dir in "${dirs[@]}"; do
    mkdir -p "${data_dir}/${dir}"
  done
}

function prepare_default_env_files() {
  for svc in "${services[@]}"; do
    touch "${data_dir}/${svc}/${svc}.env"
  done
}

function docker_compose_up() {
    docker compose up -d
}

prepare_dir
prepare_default_env_files
docker_compose_up