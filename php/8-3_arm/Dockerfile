# Stage 1: Build environment
FROM alpine:3.12 AS builder

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

# Installieren von perl-readline anstelle von perl-term-readline
RUN apk add --no-cache perl-readline


# Herunterladen und Hinzufügen des GPG-Schlüssels für das Sury PHP-Repository
RUN curl --insecure https://packages.sury.org/php/apt.gpg -o /etc/apk/keys/php-alpine.rsa.pub

# Hinzufügen des Sury PHP-Repositorys zur sources.list.d
RUN echo "https://packages.sury.org/php/3.12/main" >> /etc/apk/repositories

# Installation der angegebenen PHP-Erweiterungen
RUN apk update && apk add --no-cache \
    php8.3 \
    php8.3-common \
    php8.3-cli \
    php8.3-gd \
    php8.3-mysqlnd \
    php8.3-mbstring \
    php8.3-bcmath \
    php8.3-xml \
    php8.3-fpm \
    php8.3-curl \
    php8.3-zip \
    php8.3-sqlite3 \
    php8.3-ldap \
    php8.3-imagick \
    php8.3-gmp \
    php8.3-intl \
    php8.3-bz2

# Erstellen eines symbolischen Links, falls dieser noch nicht existiert
RUN ln -s /usr/bin/php8.3 /usr/bin/php

# Überprüfung der PHP-Version und Erstellen des Container-Benutzers
RUN php -v && adduser -D -h /home/container container

# Composer-Installation
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Ändern des PHP-Sessionspeicherorts auf /home/container/tmp
RUN sed -i 's/\/var\/lib\/php\/sessions/\/home\/container\/tmp/g' /etc/php8.3/php.ini

# Stage 2: Final environment
FROM alpine:3.12

# Kopieren der erforderlichen Dateien aus dem Builder-Stage
COPY --from=builder / /

# Festlegen des Benutzers und Arbeitsverzeichnisses
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
