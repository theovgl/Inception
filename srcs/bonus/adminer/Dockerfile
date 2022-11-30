FROM alpine:3.16

RUN apk update && apk add --no-cache wget tar git

RUN apk add --no-cache php php-session php-cli php-mbstring php-bz2 php-common php-fpm php-mysqli mariadb-client

RUN mkdir -p /var/www/adminer

RUN adduser -D -H -u 1000 -s /bin/bash -G www-data www-data

RUN chown -R www-data:www-data /var/www/adminer

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php \
	&& mv adminer-4.8.1-mysql.php /var/www/adminer/index.php

COPY ./tools/docker-entrypoint.sh ~/
ENTRYPOINT [ "/bin/sh" , "~/docker-entrypoint.sh" ]

EXPOSE 9000

COPY ./conf/php-fpm.conf /etc/php8/php-fpm.d/www.conf

CMD [ "php-fpm8", "-F" ]
