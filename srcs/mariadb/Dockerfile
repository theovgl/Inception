FROM alpine:3.16

RUN apk update

RUN apk add --no-cache mariadb mariadb-client

RUN mysql_secure_installation
