#!/usr/bin/env bash
set -e
set -u

VAULT_EXPORT_DIR="/backup/"
mkdir -p "$VAULT_EXPORT_DIR"

BW_CLIENTID=$(cat /run/secrets/bw_clientid)
BW_CLIENTSECRET=$(cat /run/secrets/bw_clientsecret)

BW_CLIENTID="$BW_CLIENTID" BW_CLIENTSECRET="$BW_CLIENTSECRET" bw login --apikey --nointeraction

unset BW_CLIENTID
unset BW_CLIENTSECRET

SESSION_KEY=$(bw unlock --passwordfile /run/secrets/bw_password --raw --nointeraction)

bw export --format encrypted_json \
          --session "$SESSION_KEY" \
          --output "$VAULT_EXPORT_DIR" \
          --nointeraction

unset SESSION_KEY
bw logout --nointeraction
