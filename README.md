# n8n VPS Production Demo

**Self-hosted n8n deployment on a Linux VPS using Docker, PostgreSQL, Redis and Caddy.**

This repository demonstrates a practical self-hosted automation stack with persistent storage, Redis-backed queue execution and HTTPS termination.

> Portfolio / demonstration project. Do not use the example credentials in production.

## Architecture

```text
                         Internet
                            │
                            ▼
                    ┌───────────────┐
                    │     Caddy     │
                    │  HTTPS / TLS  │
                    └───────┬───────┘
                            │
                            ▼
                    ┌───────────────┐
                    │      n8n      │
                    │    Main       │
                    └───────┬───────┘
                            │
                  ┌─────────┴─────────┐
                  │                   │
                  ▼                   ▼
          ┌─────────────┐      ┌─────────────┐
          │ PostgreSQL  │      │    Redis    │
          │     16      │      │     7       │
          └─────────────┘      └──────┬──────┘
                                      │
                                      ▼
                               ┌─────────────┐
                               │ n8n Worker  │
                               └─────────────┘
```

## Stack

| Component | Purpose |
|---|---|
| Debian / Linux | VPS operating system |
| Docker | Container runtime |
| Docker Compose | Service orchestration |
| n8n | Automation platform |
| PostgreSQL 16 | Persistent database |
| Redis 7 | Queue backend |
| Caddy | Reverse proxy / HTTPS |
| SSH | Server administration |

## Project Structure

```text
n8n-vps-production-demo/
├── docker-compose.yml
├── .env.example
├── .gitignore
├── Caddyfile
├── README.md
│
├── scripts/
│   ├── backup.sh
│   ├── restore.sh
│   └── healthcheck.sh
│
└── docs/
    ├── deployment.md
    ├── backup-restore.md
    └── troubleshooting.md
```

## Deployment

### 1. Clone

```bash
git clone https://github.com/[USERNAME]/n8n-vps-production-demo.git
cd n8n-vps-production-demo
```

### 2. Configure environment

```bash
cp .env.example .env
nano .env
```

Generate a strong encryption key:

```bash
openssl rand -hex 32
```

Use the generated value for `N8N_ENCRYPTION_KEY`.

### 3. Start the stack

```bash
docker compose pull
docker compose up -d
```

Check status:

```bash
docker compose ps
```

### 4. Validate configuration

```bash
docker compose config
```

### 5. Check HTTPS

After DNS points the hostname to the VPS:

```bash
curl -I https://n8n.example.com
```

## Useful Commands

```bash
docker compose ps
docker compose logs --tail=100 n8n
docker compose logs --tail=100 worker
docker compose logs --tail=100 postgres
docker compose logs --tail=100 redis
docker compose logs --tail=100 caddy
```

## Backup

Create a PostgreSQL backup:

```bash
./scripts/backup.sh
```

Restore a selected SQL dump:

```bash
./scripts/restore.sh backups/n8n_YYYYMMDD_HHMMSS.sql
```

Restore should be tested on a non-production copy before relying on it for disaster recovery.

## Health Check

```bash
./scripts/healthcheck.sh
```

The script checks:

- Docker Compose service state
- PostgreSQL readiness
- Redis responsiveness
- local n8n HTTP response
- Caddy container state

## Security Notes

- `.env` is ignored by Git.
- Database and Redis ports are not published to the Internet.
- HTTPS is terminated by Caddy.
- Credentials belong in environment variables or n8n credentials.
- SSH should use key-based authentication.
- Backups should be stored off the VPS for real deployments.

## Production Checklist

- [ ] Strong passwords
- [ ] Strong `N8N_ENCRYPTION_KEY`
- [ ] Firewall configured
- [ ] SSH hardened
- [ ] DNS verified
- [ ] HTTPS verified
- [ ] Backups scheduled
- [ ] Off-server backup copy
- [ ] Restore procedure tested
- [ ] Monitoring configured
- [ ] Resource limits reviewed

## Disclaimer

This repository is a portfolio demonstration. Review all configuration for the target environment before production use.
