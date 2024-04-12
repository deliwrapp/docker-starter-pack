# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG PHP_VERSION
ARG NODE_VERSION

# "php" stage
FROM php:${PHP_VERSION}-fpm AS php

WORKDIR /home/wwwroot/app

# Server configuration 
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y --no-install-recommends vim nano curl git debconf wget zip unzip locales acl subversion
RUN apt-get install -y --no-install-recommends apt-transport-https ca-certificates apt-utils build-essential mailutils
RUN apt-get install -y --no-install-recommends zip unzip g++
RUN apt-get install -y --no-install-recommends libzip-dev zlib1g-dev libmcrypt-dev libxslt-dev libicu-dev libxml2-dev libonig-dev
RUN apt-get install -y --no-install-recommends libwebp-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libgd-dev libfreetype6-dev 
RUN apt-get install -y --no-install-recommends gnupg gnupg1 gnupg2

# Locale configuration 
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen

# Install and Configure composer 
RUN curl -sSk https://getcomposer.org/installer | php -- --disable-tls && \
    mv composer.phar /usr/local/bin/composer

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1

# Install and Configure NodeJs & NPM 
RUN	curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN	apt-get update && apt-get upgrade -y 
RUN apt-get install -y nodejs
RUN echo "Node: " && node --version
RUN echo "NPM: " && npm --version

# CONFIG php ini
# RUN mv $PHP_INI_DIR/php.ini-development $PHP_INI_DIR/php.ini
COPY php.ini /etc/php/${PHP_VERSION}/php.ini
COPY php.ini /usr/local/etc/php/
COPY php-fpm-pool.conf /etc/php/${PHP_VERSION}/pool.d/www.conf

# Install symfony cli
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    &&  mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# DOCKER CONFIG AND INSTALL EXTENSIONS
RUN docker-php-ext-configure gd
RUN docker-php-ext-configure zip
RUN docker-php-ext-install -j$(nproc) gd zip
RUN docker-php-ext-install mysqli pdo pdo_mysql opcache
RUN docker-php-ext-install posix exif intl
RUN docker-php-ext-install calendar dom mbstring
RUN docker-php-ext-install xsl xml fileinfo
RUN pecl install apcu && docker-php-ext-enable apcu


# CONFIG DEV GROUP
RUN groupadd dev -g 999
RUN useradd dev -g dev -d /home/dev -m

# End config
RUN chown -R www-data.www-data . 

# Clean container creation process
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/lib/{apt,dpkg,cache,log}
RUN rm -f /etc/apt/sources.list.d/nodejs.list

WORKDIR /home/wwwroot/

# Export Port
EXPOSE 9000

# Command to run
CMD ["php-fpm"]
