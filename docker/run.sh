#!/bin/bash

if [ -z "$MYSQL_ROOT_PASSWORD"]; then
  echo "MYSQL_ROOT_PASSWORD must be set."
  exit 1
fi

if ! docker >/dev/null network inspect instahubnet; then
  docker network create instahubnet
fi

# cd to the directory where the script is
cd "$(dirname "$0")"

echo -e "\nRunning DB..."
if docker >/dev/null inspect db; then
  echo "db exists, restarting..."
  docker start db
else
  docker run -d --network instahubnet --name db -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD instahubdb
fi

echo -e "\nWaiting for DB to start"
until [ `docker logs db 2>&1 | grep ready.for.connections | wc -l` -gt 1 ]; do
  echo Waiting...
  sleep 3
done


echo -e "\nRunning Apache..."
docker run --network instahubnet -d --name apache --rm -v $PWD/..:/var/www/html -p80:80 instahubwww

echo -e "\nArtisan migrate.."
docker exec apache php artisan migrate
docker exec apache php artisan migrate --path=/database/migrations/users

echo -e "\nUp and running..."
