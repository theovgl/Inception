FROM alpine:3.16

RUN apk update && apk add --no-cache mariadb mariadb-client

COPY ./docker-entrypoint.sh ~/

EXPOSE 3306

ENV MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD
ENV MYSQL_USER = $MYSQL_USER
ENV MYSQL_PASSWORD = $MYSQL_PASSWORD

RUN rm -rf /var/lib/mysql && mkdir /run/mysqld

ENTRYPOINT ["/bin/sh", "~/docker-entrypoint.sh"]
