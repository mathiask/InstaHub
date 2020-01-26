#! /bin/bash

cd "$(dirname "$0")"

docker build -t instahubdb .

cd ..
sed -r -e 's/^DB_HOST=.*/DB_HOST=db/'\
       -e 's/^(DB_(DATABASE|USERNAME|PASSWORD))=.*/\1=instahub/'\
  .env.example\
  >>.env

docker run --rm --volume $PWD:/app composer install
