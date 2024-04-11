# Stage 1: Build environment
FROM debian:buster-slim AS builder

LABEL author="Amuria-Codes (https://auroa.cloud)"
LABEL maintainer="hello@auroa.cloud"
LABEL org.opencontainers.image.source="https://github.com/medaria/pterodactyl/"
LABEL org.opencontainers.image.description="A Docker image to run PHP 8.2 on Pterodactyl"

# Updating and installing the necessary PHP dependencies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Downloading and adding the GPG key for the Sury PHP repository
RUN curl https://packages.sury.org/php/apt.gpg -o /etc/apt/trusted.gpg.d/php.gpg

# Adding the Sury PHP repository to sources.list.d
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# Installation of specified PHP extensions
RUN apt-get update && apt-get install -y \
    php8.2-common \
    php8.2-cli \
    php8.2-gd \
    php8.2-mysql \
    php8.2-mbstring \
    php8.2-bcmath \
    php8.2-xml \
    php8.2-fpm \
    php8.2-curl \
    php8.2-zip \
    php8.2-sqlite3 \
    php8.2-ldap \
    php8.2-imagick \
    php8.2-gmp \
    php8.2-bcmath \
    php8.2-intl \
    php8.2-bz2

# Create symbolic link if it doesn't already exist
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php8.2 /usr/bin/php; fi

# Check PHP version and create container user
RUN php -v && useradd -d /home/container -m container

# Composer installation
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Change PHP session location to /home/container/tmp
RUN sed -i 's/\/var\/lib\/php\/sessions/\/home\/container\/tmp/g' /etc/php/8.2/fpm/php.ini

# Stage 2: Final environment
FROM debian:buster-slim

# Copying necessary files from builder stage
COPY --from=builder / /

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]
