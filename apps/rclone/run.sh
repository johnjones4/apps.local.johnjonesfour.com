#!/bin/bash

archive_source () {
  archivedir=/data/"$1"
  mkdir -p "$archivedir"
  rclone sync "$1": "$archivedir" &> /tmp/log.txt
  curl -X POST --data-binary /tmp/log.txt http://jabba:8070/api/jobrun/rclone
  rm /tmp/log.txt
}

archive_sources () {
  for remote in $(echo $REMOTES | sed "s/,/ /g")
  do
    echo "$remote"
    archive_source "$remote"
  done
}

while :
do
  archive_sources
  sleep 86400
done
