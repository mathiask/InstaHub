#! /bin/bash

# cd to the directory where the script is
cd "$(dirname "$0")"

echo -e "\nBuilding DB image..."
docker build -t instahubdb db

echo -e "\nBuilding PHP image..."
docker build -t instahubwww www

cd ..
echo -e "\nCreating .env from .env.example..."
sed -r -e 's/^DB_HOST=.*/DB_HOST=db/'\
       -e 's/^(DB_(DATABASE|USERNAME|PASSWORD))=.*/\1=instahub/'\
  .env.example\
  >>.env

echo -e "\nRunning composer (in a docker container)..."
docker run --rm --volume $PWD:/app composer install

echo -e "\nSetting up Apache..."
# docker run -d --name apache --rm -v $PWD:/var/www/html php:7.3.1-apache
# docker exec apache chown -R www-data /var/www/html/public/storage /var/www/html/public/bootstrap/cache
# docker exec apache php artisan key:generate
# docker stop apache
