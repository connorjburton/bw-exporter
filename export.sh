#!/usr/bin/env bash
set -e
set -u

VAULT_EXPORT_DIR=/backup
BW_CLIENTID=${BW_CLIENTID:-}
BW_CLIENTSECRET=${BW_CLIENTSECRET:-}
BW_PASSWORD=${BW_PASSWORD:-}
EXPORT_FILE="$VAULT_EXPORT_DIR/bw-vault.json"

mkdir -p "$VAULT_EXPORT_DIR"

bw login --apikey --raw
bw unlock --passwordenv BW_PASSWORD
bw export --format encrypted_json --output "$EXPORT_FILE"

echo "Vault exported to $EXPORT_FILE"

bw lock

unset BW_SESSION
