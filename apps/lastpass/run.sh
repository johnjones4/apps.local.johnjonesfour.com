#!/bin/bash

while :
do
  lpass export > /data/passwords.csv
  sleep 86400
done
