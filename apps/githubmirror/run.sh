#!/bin/bash

while :
do
  ./mirror.sh |& curl -d @- http://jabba:8070/api/jobrun/github
  sleep 86400
done
