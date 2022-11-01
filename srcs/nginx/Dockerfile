FROM alpine:3.16

# Update the Package list
RUN apk update

# Install prerequisites
RUN apk add openssl curl ca-certificates

# Install nginx
RUN apk add nginx

# Generate SSL certificate
RUN openssl req -x509 \
            -new \
            -newkey rsa:4096 \
            -nodes \
            -keyout /etc/ssl/private/nginx-selfsigned.key \
            -out /etc/ssl/certs/nginx-selfsigned.cert -sha256 -days 365 \
            -subj "/C=FR/CN=tvogel.42.fr"

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
