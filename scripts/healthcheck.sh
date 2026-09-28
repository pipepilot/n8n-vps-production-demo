#!/usr/bin/env bash
set -euo pipefail

echo "== Docker Compose status =="
docker compose ps

echo
echo "== PostgreSQL =="
docker compose exec -T postgres pg_isready \
  -U "${POSTGRES_USER:-n8n}" \
  -d "${POSTGRES_DB:-n8n}"

echo
echo "== Redis =="
docker compose exec -T redis redis-cli ping

echo
echo "== n8n local HTTP =="
docker compose exec -T n8n wget -qO- http://127.0.0.1:5678/healthz || true

echo
echo "Health check completed."
