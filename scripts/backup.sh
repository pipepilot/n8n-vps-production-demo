#!/usr/bin/env bash
set -euo pipefail

mkdir -p backups

timestamp="$(date +%Y%m%d_%H%M%S)"
output="backups/n8n_${timestamp}.sql"

docker compose exec -T postgres \
  pg_dump -U "${POSTGRES_USER:-n8n}" "${POSTGRES_DB:-n8n}" \
  > "$output"

echo "Backup created: $output"
