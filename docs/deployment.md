# Deployment Guide

## Requirements

- Debian or another Linux VPS
- Docker Engine
- Docker Compose plugin
- DNS record pointing to the VPS
- TCP ports 80 and 443 available

## Initial setup

```bash
git clone https://github.com/[USERNAME]/n8n-vps-production-demo.git
cd n8n-vps-production-demo
cp .env.example .env
nano .env
```

Generate the encryption key:

```bash
openssl rand -hex 32
```

Validate Compose:

```bash
docker compose config
```

Start:

```bash
docker compose up -d
```

Verify:

```bash
docker compose ps
docker compose logs --tail=100 n8n
```

## DNS

Create an A record such as:

```text
n8n.example.com -> VPS_PUBLIC_IP
```

Then test:

```bash
dig +short n8n.example.com
```

Caddy will obtain a TLS certificate after the hostname resolves correctly and ports 80/443 are reachable.
