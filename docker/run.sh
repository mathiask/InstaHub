#!/bin/bash

if [ -z "$MYSQL_ROOT_PASSWORD"]; then
  echo "MYSQL_ROOT_PASSWORD must be set."
  exit 1
fi

docker network create instanet

