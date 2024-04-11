# Stage 1: Build environment
FROM alpine:3.19 AS builder

LABEL author="Amuria-Codes (https://auroa.cloud)"
LABEL maintainer="hello@auroa.cloud"
LABEL org.opencontainers.image.source="https://github.com/medaria/pterodactyl/"
LABEL org.opencontainers.image.description="A Docker image to run PHP 8.3 on Pterodactyl"

# Update der Paketliste
RUN apk update

# Installieren von Curl
RUN apk add --no-cache curl

# Installieren von ca-certificates
RUN apk add --no-cache ca-certificates

# Installieren von gnupg
RUN apk add --no-cache gnupg

# Installieren von Perl
RUN apk add --no-cache perl

# Herunterladen und Hinzufügen des GPG-Schlüssels für das Sury PHP-Repository
RUN curl --insecure https://packages.sury.org/php/apt.gpg -o /etc/apk/keys/php-alpine.rsa.pub

# Installation der angegebenen PHP-Erweiterungen
RUN apk update 
RUN apk add --no-cache
RUN apk add --upgrade php83
RUN apk add --upgrade php83-common 
RUN apk add --upgrade php83-cli
RUN apk add --upgrade php83-gd
RUN apk add --upgrade php83-mysqlnd
RUN apk add --upgrade php83-mbstring
RUN apk add --upgrade php83-bcmath
RUN apk add --upgrade php83-xml
RUN apk add --upgrade php83-fpm
RUN apk add --upgrade php83-curl
RUN apk add --upgrade php83-zip
RUN apk add --upgrade php83-sqlite3
RUN apk add --upgrade php83-ldap
RUN apk add --upgrade php83-imagick
RUN apk add --upgrade php83-gmp
RUN apk add --upgrade php83-intl
RUN apk add --upgrade php83-bz2

# Erstellen eines symbolischen Links, falls dieser noch nicht existiert
RUN ln -s /usr/bin/php8.3 /usr/bin/php

# Überprüfung der PHP-Version und Erstellen des Container-Benutzers
RUN php -v && adduser -D -h /home/container container

# Composer-Installation
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Ändern des PHP-Sessionspeicherorts auf /home/container/tmp
RUN sed -i 's/\/var\/lib\/php\/sessions/\/home\/container\/tmp/g' /etc/php8.3/php.ini

# Stage 2: Final environment
FROM alpine:3.19

# Kopieren der erforderlichen Dateien aus dem Builder-Stage
COPY --from=builder / /

# Festlegen des Benutzers und Arbeitsverzeichnisses
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
