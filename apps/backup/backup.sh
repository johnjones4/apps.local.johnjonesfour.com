#!/bin/bash

export PGPASSWORD="$POSTGRES_PASSWORD"

while :
do
  tar zcvf /backup/apps.tar.gz /apps
  while read d; do
    echo "Backing up $d"
    pg_dump "$d" -U $POSTGRES_USER -h $POSTGRES_HOST > /backup/"$d".sql
    echo "Done"
  done </dbs.txt
  sleep 86400
done
