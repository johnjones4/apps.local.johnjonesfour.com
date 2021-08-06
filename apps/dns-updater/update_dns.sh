#!/bin/bash

while :
do
  # IPV4_ADDRESS=$(dig +short A myip.opendns.com @resolver1.opendns.com)
  IPV6_ADDRESS=$(dig +short AAAA myip.opendns.com @resolver1.opendns.com)

  # echo $IPV4_ADDRESS
  echo $IPV6_ADDRESS

  sed "s/IPV6_ADDRESS/$IPV6_ADDRESS/g" change_template.json > change_batch.json

  export AWS_PAGER=""

  aws route53 change-resource-record-sets --hosted-zone-id $ZONE_ID --change-batch file://change_batch.json

  rm change_batch.json

  sleep 86400
done
