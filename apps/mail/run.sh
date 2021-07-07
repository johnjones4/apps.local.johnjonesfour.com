#!/bin/bash

mkdir -p /data/gmail

mkdir -p /data/proton

/src/proton-bridge-1.8.7/proton-bridge --noninteractive &

sleep 10

while :
do
  offlineimap -c /config/offlineimaprc | curl -d @- http://jabba:8070/api/jobrun/mail
  sleep 86400
done
