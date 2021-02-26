#!/bin/bash

while read d; do
  echo "SELECT 'CREATE DATABASE $d' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = '$d')\gexec"
done <backup/dbs.txt
