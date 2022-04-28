FROM php:5-apache-stretch as builder
COPY . /var/www/polr
WORKDIR /var/www/polr/
RUN apt-get update --yes && apt-get install git --yes
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install --no-dev -o

FROM php:5-apache-stretch
RUN a2enmod rewrite && mkdir /var/www/polr
COPY ./docker/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY --from=builder /var/www/polr /var/www/polr
RUN chown -R www-data /var/www/polr
EXPOSE 80