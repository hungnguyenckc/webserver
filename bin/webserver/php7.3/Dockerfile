FROM php:7.3-apache

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update --fix-missing --no-install-recommends
RUN apt-get -y upgrade

# Install important libraries
RUN apt-get -y install --fix-missing \
    libcurl3-dev openssl \
    libxml2-dev zlib1g-dev libicu-dev \
    libsqlite3-dev libsqlite3-0 \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev git \
    libmemcached-dev libzip-dev libwebp-dev libonig-dev

# Install MySQL
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install mysqli

# Install GD
RUN docker-php-ext-configure gd \
  --with-png-dir=/usr/include/ \
  --with-jpeg-dir=/usr/include/ \
  --with-freetype-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd

# Install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Install SOAP
RUN docker-php-ext-install soap

# Other PHP7 Extensions
RUN docker-php-ext-install curl
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install json
RUN docker-php-ext-install zip
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install gettext
RUN docker-php-ext-install exif

# Enable apache modules
RUN a2enmod rewrite headers vhost_alias

RUN service apache2 restart

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

USER www-data