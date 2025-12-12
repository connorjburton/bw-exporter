#!/usr/bin/env bash
set -e
set -u

VAULT_EXPORT_DIR=/backup/
BW_CLIENTID=${BW_CLIENTID:-}
BW_CLIENTSECRET=${BW_CLIENTSECRET:-}
BW_PASSWORD=${BW_PASSWORD:-}

mkdir -p "$VAULT_EXPORT_DIR"

bw login --apikey --raw --nointeraction
export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw --nointeraction)
bw export --format encrypted_json --session "$BW_SESSION" --output "$VAULT_EXPORT_DIR" --nointeraction
