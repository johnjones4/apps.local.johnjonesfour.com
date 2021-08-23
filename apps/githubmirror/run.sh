#!/bin/bash

while :
do
  ./mirror.sh &> /tmp/log.txt
  curl -X POST --data-binary @/tmp/log.txt http://jabba:8070/api/jobrun/github
  rm /tmp/log.txt
  sleep "$DELAY_STD"
done
