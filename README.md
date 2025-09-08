Monitor Postgre Database

docker system df
docker volume inspect postgres_data
du -sh /var/lib/docker/volumes/postgres_data/\_data

Backup database
mkdir -p /opt/backups/postgres

bash file untuk database

#!/bin/bash

# Threshold disk usage in percent

THRESHOLD=85
VOLUME_PATH="/var/lib/docker/volumes/postgres_data/\_data"
BACKUP_DIR="/opt/backups/postgres"
DB_USER="admin"
DB_CONTAINER="app-postgres"

# Create backup folder if not exists

mkdir -p "$BACKUP_DIR"

# Check disk usage

USAGE=$(df -h "$VOLUME_PATH" | tail -1 | awk '{print $5}' | tr -d '%')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
TIMESTAMP=$(date +"%Y-%m-%d_%H%M")
  BACKUP_FILE="$BACKUP*DIR/myapp*$TIMESTAMP.sql"
echo "Disk usage $USAGE% >= $THRESHOLD%, starting backup to $BACKUP_FILE"

# Execute pg_dumpall in container

docker exec "$DB_CONTAINER" pg_dumpall -U "$DB_USER" > "$BACKUP_FILE"

echo "Backup completed: $BACKUP_FILE"
else
echo "Disk usage $USAGE% < $THRESHOLD%, no backup needed"
fi

Cron (cek setiap sejam)
sudo crontab -e
0 \* \* \* \* /usr/local/bin/postgres-backup.sh >> /var/log/postgres-backup.log 2>&1

delete more than 30 hari
find /opt/backups/postgres/ -type f -mtime +30 -name "\*.sql" -delete
