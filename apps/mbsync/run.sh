#!/bin/bash

mkdir -p /data/gmail

mkdir -p /data/proton

/src/proton-bridge-1.8.7/proton-bridge --noninteractive &

sleep 10

while :
do
  mbsync protonmail -D -c /config/mbsyncrc
  sleep 86400
done
