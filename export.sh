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
export BW_SESSION=$(bw unlock --passwordenv BW_PASSWORD --raw)
bw export --format encrypted_json --session "$BW_SESSION" --output "$EXPORT_FILE"

echo "Vault exported to $EXPORT_FILE"

tail -f /dev/null
