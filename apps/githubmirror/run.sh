#!/bin/bash

while :
do
  output=$(./mirror.sh)
  curl -X POST --data "$output" http://jabba:8070/api/jobrun/github
  sleep 86400
done
