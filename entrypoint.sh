#!/bin/bash

# Tunggu MySQL siap
echo "Waiting for MySQL..."
until mysql -h"$DB_HOST" -u"$DB_USERNAME" -p"$DB_PASSWORD" -e "SELECT 1" &>/dev/null; do
  sleep 2
done
echo "MySQL is up!"

# Import database jika belum ada tabel
if [ -f "/tmp/database.sql" ]; then
  echo "Importing database..."
  mysql -h"$DB_HOST" -u"$DB_USERNAME" -p"$DB_PASSWORD" "$DB_DATABASE" < /tmp/database.sql
  echo "Database import complete!"
else
  echo "No SQL file found, skipping import."
fi

# Jalankan Apache
exec apache2-foreground
