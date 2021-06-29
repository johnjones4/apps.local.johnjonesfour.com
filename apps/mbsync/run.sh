#!/bin/bash

mkdir -p /data/gmail

while :
do
  mbsync -a -D -c /config/mbsyncrc
  sleep 86400
done
