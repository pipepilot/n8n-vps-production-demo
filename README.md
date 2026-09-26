# n8n VPS Production Demo

**Self-hosted n8n deployment on a Linux VPS using Docker, PostgreSQL, Redis and Caddy.**

This repository demonstrates how to deploy and operate an n8n automation platform on a Linux VPS with persistent storage, database support, Redis and HTTPS.

> This is a demonstration / portfolio project. It does not contain production credentials or private infrastructure data.

---

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
                    │  Automation   │
                    └───────┬───────┘
                            │
                 ┌──────────┴──────────┐
                 │                     │
                 ▼                     ▼
          ┌─────────────┐       ┌─────────────┐
          │ PostgreSQL  │       │    Redis    │
          │    16       │       │     7       │
          └─────────────┘       └─────────────┘
```

---

## Stack

| Component | Purpose |
|---|---|
| Debian / Linux | VPS operating system |
| Docker | Container runtime |
| Docker Compose | Service orchestration |
| n8n | Automation platform |
| PostgreSQL | Persistent n8n database |
| Redis | Queue / execution infrastructure |
| Caddy | Reverse proxy |
| Let's Encrypt | TLS certificates |
| SSH | Server administration |

---

## Project Structure

```text
n8n-vps-production-demo/
│
├── docker-compose.yml
├── .env.example
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

---

## Services

### n8n

The main automation platform.

Responsibilities:

- workflow execution
- webhook processing
- API integrations
- Telegram integrations
- automation logic

### PostgreSQL

Used as the persistent database for n8n.

The database stores n8n configuration and execution-related data.

### Redis

Provides Redis-backed infrastructure for queue-based n8n deployments.

### Caddy

Acts as the public reverse proxy.

Responsibilities:

- HTTPS
- TLS certificate management
- reverse proxy
- HTTP security configuration
- access logging

---

## Deployment

### 1. Clone the repository

```bash
git clone https://github.com/[USERNAME]/n8n-vps-production-demo.git
cd n8n-vps-production-demo
```

### 2. Create environment configuration

```bash
cp .env.example .env
nano .env
```

Example:

```env
POSTGRES_DB=n8n
POSTGRES_USER=n8n
POSTGRES_PASSWORD=change_me

N8N_HOST=n8n.example.com
N8N_PROTOCOL=https

N8N_ENCRYPTION_KEY=change_me_to_a_long_random_value

REDIS_HOST=redis
REDIS_PORT=6379
```

> Never commit `.env` to Git.

---

### 3. Start the stack

```bash
docker compose up -d
```

Check containers:

```bash
docker compose ps
```

---

## Logs

Check all services:

```bash
docker compose logs
```

n8n:

```bash
docker compose logs -f n8n
```

PostgreSQL:

```bash
docker compose logs -f postgres
```

Redis:

```bash
docker compose logs -f redis
```

Caddy:

```bash
docker compose logs -f caddy
```

---

## Health Checks

Basic container check:

```bash
docker compose ps
```

Check listening ports:

```bash
ss -tulpn
```

Check HTTPS:

```bash
curl -I https://n8n.example.com
```

Check DNS:

```bash
dig n8n.example.com
```

---

## Backup

A production-style deployment should have a recovery procedure, not only a backup command.

Example PostgreSQL backup:

```bash
docker compose exec -T postgres \
  pg_dump -U n8n n8n > backup.sql
```

Restore example:

```bash
cat backup.sql | \
docker compose exec -T postgres \
  psql -U n8n n8n
```

For real deployments, backups should additionally consider:

- encryption
- off-server storage
- retention
- scheduled execution
- restore testing

---

## Troubleshooting Workflow

When a service does not work:

```text
Problem
   │
   ▼
docker compose ps
   │
   ▼
Check container logs
   │
   ▼
Check configuration
   │
   ▼
Check networking
   │
   ▼
Check DNS / HTTPS
   │
   ▼
Test with curl
   │
   ▼
Apply fix
   │
   ▼
Verify
```

Typical commands:

```bash
docker compose ps
docker compose logs --tail=100 n8n
docker inspect n8n
docker network inspect <network>
curl -I https://n8n.example.com
ss -tulpn
dig n8n.example.com
```

---

## Security Considerations

This demo follows several basic security principles:

- secrets are stored outside Git
- `.env` is excluded from the repository
- `.env.example` contains placeholders only
- HTTPS is used for public access
- database ports do not need to be publicly exposed
- containers communicate through an internal Docker network
- SSH access should use keys rather than passwords where possible

---

## Production Checklist

Before using a similar configuration for a real service:

- [ ] Strong PostgreSQL password
- [ ] Strong n8n encryption key
- [ ] `.env` excluded from Git
- [ ] HTTPS enabled
- [ ] DNS correctly configured
- [ ] Firewall configured
- [ ] SSH secured
- [ ] Backups configured
- [ ] Backup restoration tested
- [ ] Logs reviewed
- [ ] Resource usage monitored

---

## What This Project Demonstrates

This project demonstrates practical experience with:

- Linux VPS deployment
- Docker
- Docker Compose
- n8n
- PostgreSQL
- Redis
- Caddy
- HTTPS / TLS
- DNS
- SSH
- backups
- troubleshooting

---

## Disclaimer

This repository is a portfolio demonstration.

Configuration should be reviewed and adapted before use in a real production environment.

---

## License

This project is provided for educational and demonstration purposes.