# Stage 1: Build environment
FROM debian:bullseye-slim AS builder

LABEL author="Amuria-Codes (https://auroa.cloud)"
LABEL maintainer="hello@auroa.cloud"
LABEL org.opencontainers.image.source="https://github.com/medaria/pterodactyl/"
LABEL org.opencontainers.image.description="A Docker image to run PHP 8.3 on Pterodactyl"

# Updating and installing necessary dependencies
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common \
    libterm-readline-gnu-perl \
    mariadb-server \
    nginx \
    wget \
    unzip

# Adding the GPG key and repository for PHP 8.3
RUN curl -fsSL https://packages.sury.org/php/apt.gpg | apt-key add -
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

# Installing PHP 8.3 and necessary extensions
RUN apt-get update && apt-get install -y \
    php8.3-common \
    php8.3-cli \
    php8.3-gd \
    php8.3-mysql \
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
    php8.3-bcmath \
    php8.3-intl \
    php8.3-bz2

# Create symbolic link if it doesn't already exist
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php8.3 /usr/bin/php; fi

# Check PHP version and create container user
RUN php -v && useradd -d /home/container -m container

# Composer installation
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Change PHP session location to /home/container/tmp
RUN sed -i 's/\/var\/lib\/php\/sessions/\/home\/container\/tmp/g' /etc/php/8.3/fpm/php.ini

# Stage 2: Final environment
FROM debian:bullseye-slim

# Copying necessary files from builder stage
COPY --from=builder / /

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
COPY ../nginx.conf /nginx/nginx.conf
COPY ../php-fpm.conf /php/8.3/fpm/php-fpm.conf

CMD [ "/bin/bash", "/entrypoint.sh" ]
