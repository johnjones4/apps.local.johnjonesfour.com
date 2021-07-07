#!/bin/bash

while :
do
  lpass export > /data/passwords.csv
  status=$?
  if [ "$status" -ne "0" ]; then
    curl -X POST --data "error: $status" http://jabba:8070/api/jobrun/lastpass
  else
    curl -X POST --data "ok: $status" http://jabba:8070/api/jobrun/lastpass
  fi
  sleep 86400
done
