FROM php:7.0-fpm

RUN apt-get update && apt-get install -y \
  libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev \
  git vim unzip \
  && docker-php-ext-install pdo_mysql mysqli mbstring gd iconv mcrypt \
  && apt-get clean
# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
WORKDIR /var/www/html
COPY composer.json .
COPY database/ .
EXPOSE 8080
#RUN composer install
