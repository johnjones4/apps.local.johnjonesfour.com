#!/bin/bash

while :
do
  lpass export --non-interactive > /data/passwords.csv
  echo $? | curl -d @- http://jabba:8070/api/jobrun/lastpass
  sleep 86400
done
