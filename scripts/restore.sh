#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 backups/n8n_YYYYMMDD_HHMMSS.sql"
  exit 1
fi

backup="$1"

if [[ ! -f "$backup" ]]; then
  echo "Backup file not found: $backup"
  exit 1
fi

echo "Restoring: $backup"
echo "WARNING: this writes into the configured n8n database."
read -r -p "Continue? [y/N] " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
  echo "Cancelled."
  exit 0
fi

cat "$backup" | docker compose exec -T postgres \
  psql -U "${POSTGRES_USER:-n8n}" "${POSTGRES_DB:-n8n}"

echo "Restore completed."
