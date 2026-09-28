# Backup and Restore

## Backup

```bash
./scripts/backup.sh
```

The resulting SQL dump is placed in `backups/`.

The `backups/` directory is intentionally ignored by Git.

## Restore

```bash
./scripts/restore.sh backups/n8n_YYYYMMDD_HHMMSS.sql
```

A restore operation changes database contents. For production, first verify the backup against a test environment.

## Recommended real-world policy

- Daily database backups
- Multiple retained versions
- Off-server storage
- Encryption at rest
- Periodic restore tests
- Monitoring for failed backup jobs
