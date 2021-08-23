#!/bin/bash

mkdir -p /data/gmail

mkdir -p /data/proton

/src/proton-bridge-1.8.7/proton-bridge --noninteractive &

sleep 10

while :
do
  offlineimap -o -c /config/offlineimaprc &> /tmp/log.txt
  curl -X POST --data-binary @/tmp/log.txt http://jabba:8070/api/jobrun/mail
  rm /tmp/log.txt
  sleep "$DELAY_DAILY"
done
