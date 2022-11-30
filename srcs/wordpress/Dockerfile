FROM alpine:3.16

RUN apk update && apk add --no-cache wget tar git && \
	apk add php php-fpm php-phar php-common mariadb-client php-curl php-dom php-exif php-fileinfo php-mbstring php-openssl php-xml php-zip php-mysqli php-gd php-iconv php-intl php-pdo_mysql php8-pecl-imagick imagemagick 

RUN mkdir -p /var/www/html && mkdir /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000

COPY ./tools/docker-entrypoint.sh ~/

ENTRYPOINT [ "/bin/sh" , "~/docker-entrypoint.sh" ]

RUN adduser -D -H -u 1000 -s /bin/bash -G www-data www-data

COPY ./conf/php-fpm.conf /etc/php8/php-fpm.d/www.conf

CMD [ "php-fpm8", "-F" ]
