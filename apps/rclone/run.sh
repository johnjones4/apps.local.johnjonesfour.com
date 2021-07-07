#!/bin/bash

archive_source () {
  archivedir=/data/"$1"
  mkdir -p "$archivedir"
  output=$(rclone sync "$1": "$archivedir")
  curl -X POST --data "$output" http://jabba:8070/api/jobrun/rclone
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
