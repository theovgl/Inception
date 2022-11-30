FROM alpine:3.16

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir /var/run/mysqld
RUN chmod 777 /var/run/mysqld

COPY ./tools/docker-entrypoint.sh ~/

RUN sed -i 's/skip-networking$//' /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i '/bind-address=0.0.0.0/s/^#//g' /etc/my.cnf
EXPOSE 3306

ENTRYPOINT ["/bin/sh", "~/docker-entrypoint.sh"]
