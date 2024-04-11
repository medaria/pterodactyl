# Stage 1: Build environment
FROM alpine:3.14 AS builder

LABEL author="Amuria-Codes (https://auroa.cloud)"
LABEL maintainer="hello@auroa.cloud"
LABEL org.opencontainers.image.source="https://github.com/medaria/pterodactyl/"
LABEL org.opencontainers.image.description="A Docker image to run PHP 8.3 on Pterodactyl"

# Installation der notwendigen Abhängigkeiten
RUN apk update && apk add --no-cache \
    curl \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    libterm-readline-gnu-perl # Installieren des Term::ReadLine-Moduls

# Herunterladen und Hinzufügen des GPG-Schlüssels für das Sury PHP-Repository mit der Option insecure
RUN curl --insecure https://packages.sury.org/php/apt.gpg -o /etc/apk/keys/php-alpine.rsa.pub

# Hinzufügen des Sury PHP-Repositorys zu den sources.list
RUN echo "https://packages.sury.org/php alpine/v3.14/main" >> /etc/apk/repositories

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

# Symbolischen Link erstellen, falls noch nicht vorhanden
RUN ln -s /usr/bin/php8.3 /usr/bin/php

# PHP-Version überprüfen und Benutzer im Container erstellen
RUN php -v && adduser -D -h /home/container container

# Composer-Installation
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Ändern des PHP-Sitzungsspeicherorts auf /home/container/tmp
RUN sed -i 's/\/var\/lib\/php\/sessions/\/home\/container\/tmp/g' /etc/php8/php-fpm.d/www.conf

# Stage 2: Final environment
FROM alpine:3.14

# Notwendige Dateien aus dem Builder-Stage kopieren
COPY --from=builder / /

# Benutzer im Container festlegen
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Entry Point kopieren und CMD festlegen
COPY ../entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]
