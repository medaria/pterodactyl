FROM debian:buster-slim

LABEL author="Amuria-Codes ( https://auroa.cloud )"
LABEL maintainer="hello@auroa.cloud"
LABEL org.opencontainers.image.source="https://github.com/Amuria-Codes/pterodactyl-container/"
LABEL org.opencontainers.image.description="A Docker image to run PHP 8.0 on Pterodactyl"

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

# Installation PHP 8.0
RUN apt-get update && apt-get install -y php8.0

# Installation of specified PHP extensions
RUN apt-get install -y \
    php8.0-common \
    php8.0-cli \
    php8.0-gd \
    php8.0-mysql \
    php8.0-mbstring \
    php8.0-bcmath \
    php8.0-xml \
    php8.0-fpm \
    php8.0-curl \
    php8.0-zip \
    php8.0-sqlite3 \
    php8.0-ldap \
    php8.0-imagick \
    php8.0-gmp \
    php8.0-bcmath \
    php8.0-intl \
    php8.0-bz2

# Create symbolic link if it doesn't already exist
RUN if [ ! -f /usr/bin/php ]; then ln -s /usr/bin/php8.0 /usr/bin/php; fi

# Check PHP version and create container user
RUN php -v && useradd -d /home/container -m container

# Composer installation
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Change PHP session location to /home/container/tmp
RUN sed -i 's/\/var\/lib\/php\/sessions/\/home\/container\/tmp/g' /etc/php/8.0/fpm/php.ini

USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

COPY ../entrypoint.sh /entrypoint.sh
CMD [ "/bin/bash", "/entrypoint.sh" ]
