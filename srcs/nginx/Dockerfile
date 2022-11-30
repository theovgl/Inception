FROM alpine:3.16

# Install prerequisites
RUN apk update && apk add openssl curl ca-certificates nginx

RUN mkdir -p /etc/ssl/private/wordpress; \
	mkdir -p /etc/ssl/certs/wordpress; \
	mkdir -p /etc/ssl/private/adminer; \
	mkdir -p /etc/ssl/certs/adminer

# Generate SSL certificate for main website
RUN openssl req -x509 \
            -new \
            -newkey rsa:4096 \
            -nodes \
            -keyout /etc/ssl/private/wordpress/nginx-selfsigned.key \
            -out /etc/ssl/certs/wordpress/nginx-selfsigned.cert -sha256 -days 365 \
            -subj "/C=FR/L=Paris/CN=tvogel.42.fr/O=42"

# Generate SSL certificate for adminer website
RUN openssl req -x509 \
            -new \
            -newkey rsa:4096 \
            -nodes \
            -keyout /etc/ssl/private/adminer/nginx-selfsigned.key \
            -out /etc/ssl/certs/adminer/nginx-selfsigned.cert -sha256 -days 365 \
            -subj "/C=FR/L=Paris/CN=adminer.tvogel.42.fr/O=42"

# Copy nginx config
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
