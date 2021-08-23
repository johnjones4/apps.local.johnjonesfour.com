#!/bin/bash

export PGPASSWORD="$POSTGRES_PASSWORD"

while :
do
  tar zcvf /backup/apps.tar.gz /apps
  while read d; do
    echo "Backing up $d"
    rm /backup/"$d".sql
    rm /backup/"$d".sql.gz
    pg_dump "$d" -U $POSTGRES_USER -h $POSTGRES_HOST > /backup/"$d".sql
    gzip /backup/"$d".sql
    echo "Done"
  done </dbs.txt
  sleep "$DELAY_DAILY"
done
