# Troubleshooting

## Containers are restarting

```bash
docker compose ps
docker compose logs --tail=200 n8n
docker compose logs --tail=200 worker
```

Check:

- environment variables
- database availability
- Redis availability
- encryption key
- filesystem permissions

## Caddy returns 502

```bash
docker compose logs --tail=200 caddy
docker compose ps
```

Confirm that the `n8n` service is running and reachable on the Docker network.

## PostgreSQL connection problems

```bash
docker compose exec postgres pg_isready
docker compose logs --tail=100 postgres
```

Check database host, port, user and password.

## Redis problems

```bash
docker compose exec redis redis-cli ping
docker compose logs --tail=100 redis
```

Expected response:

```text
PONG
```

## DNS / HTTPS problems

```bash
dig +short n8n.example.com
curl -Iv https://n8n.example.com
```

Separate DNS problems from reverse-proxy and application problems before changing configuration.
