#! /bin/bash

# cd to the directory where the script is
cd "$(dirname "$0")"

echo -e "\nBuilding DB image..."
docker build -t instahubdb .

cd ..
echo -e "\nCreating .env from .env.example..."
sed -r -e 's/^DB_HOST=.*/DB_HOST=db/'\
       -e 's/^(DB_(DATABASE|USERNAME|PASSWORD))=.*/\1=instahub/'\
  .env.example\
  >>.env

echo -e "\nRunning composer (in a docker container)..."
docker run --rm --volume $PWD:/app composer install
