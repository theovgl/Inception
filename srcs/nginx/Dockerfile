FROM alpine:3.16

# Install prerequisites
RUN apk update && apk add openssl curl ca-certificates nginx

# Generate SSL certificate
RUN openssl req -x509 \
            -new \
            -newkey rsa:4096 \
            -nodes \
            -keyout /etc/ssl/private/nginx-selfsigned.key \
            -out /etc/ssl/certs/nginx-selfsigned.cert -sha256 -days 365 \
            -subj "/C=FR/L=Paris/CN=tvogel.42.fr/O=42"

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
