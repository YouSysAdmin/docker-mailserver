#!/bin/bash
while true; do
  if [ -f /acme/acme.json ]; then
    jq --arg DOMAIN "${DOMAIN}" '.letsencrypt.Certificates | .[] |select(.domain.main == $DOMAIN )' /acme/acme.json | jq -r '.key' | base64 -d > /mailserver/ssl/key.pem
    jq --arg DOMAIN "${DOMAIN}" '.letsencrypt.Certificates | .[] |select(.domain.main == $DOMAIN )' /acme/acme.json | jq -r '.certificate' | base64 -d > /mailserver/ssl/cert.pem
  fi
   sleep 30
done
