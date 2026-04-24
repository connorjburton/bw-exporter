#!/usr/bin/env bash
set -e
set -u

VAULT_EXPORT_DIR="/backup/"
SECRET_PATH="/run/secrets/bw_password"
mkdir -p "$VAULT_EXPORT_DIR"

BW_CLIENTID=$(cat /run/secrets/bw_clientid)
BW_CLIENTSECRET=$(cat /run/secrets/bw_clientsecret)
BW_PASSWORD=$(cat /run/secrets/bw_password) # Keep local, don't export yet

BW_CLIENTID="$BW_CLIENTID" BW_CLIENTSECRET="$BW_CLIENTSECRET" bw login --apikey --nointeraction

export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw --nointeraction)

unset BW_CLIENTID
unset BW_CLIENTSECRET
unset BW_PASSWORD

bw export --format encrypted_json \
          --session "$BW_SESSION" \
          --output "$VAULT_EXPORT_DIR" \
          --nointeraction

unset BW_SESSION
bw logout --nointeraction
