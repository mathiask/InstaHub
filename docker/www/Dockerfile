FROM php:7.3.1-apache
LABEL description="PHP/Apache with a special config"
LABEL maintainer="Mathias Kegelmann"

RUN sed -ri -e's!DocumentRoot.*!DocumentRoot /var/www/html/public!' /etc/apache2/sites-available/000-default.conf
RUN sed -ie '172s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
RUN docker-php-ext-install pdo_mysql
RUN a2enmod rewrite
