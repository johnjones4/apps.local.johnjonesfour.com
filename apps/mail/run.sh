#!/bin/bash

mkdir -p /data/gmail

mkdir -p /data/proton

/src/proton-bridge-1.8.7/proton-bridge --noninteractive &

sleep 10

while :
do
  imap-backup
  sleep 86400
done