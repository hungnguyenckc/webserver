#Quickfix - Basebox for PHP7.2 Library now uses Debian "10" Buster, superceeding #libcurl3, stretch is most compatible at this time whilst devs workout backport.
#https://github.com/docker-library/official-images/blob/master/library/php

FROM php:7.2-apache-stretch

ARG APCU_VERSION=5.1.18
ARG USERNAME
ARG USER_UID
ARG USER_GID=$USER_UID

# Create a non-root user to use if preferred
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

ENV APACHE_RUN_USER $USERNAME
ENV APACHE_RUN_GROUP $USERNAME

RUN apt-get -y update --fix-missing --no-install-recommends
RUN apt-get -y upgrade

# Install important libraries
RUN apt-get -y install --fix-missing \
    libcurl3 libcurl3-dev openssl \
    libxml2-dev zlib1g-dev libicu-dev \
    libsqlite3-dev libsqlite3-0 mysql-client \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev

# Install MySQL
RUN docker-php-ext-install pdo_mysql 
RUN docker-php-ext-install pdo_sqlite
RUN docker-php-ext-install mysqli

# Install GD
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install -j$(nproc) gd

# Install xdebug
RUN pecl install xdebug-2.6.0
RUN docker-php-ext-enable xdebug

# Install SOAP
RUN docker-php-ext-install soap
RUN docker-php-ext-enable soap

# Install opcache
RUN docker-php-ext-install opcache
RUN docker-php-ext-configure opcache --enable-opcache

# Install APCU
RUN pecl install apcu-${APCU_VERSION} 
RUN docker-php-ext-enable apcu

# Other PHP7 Extensions
RUN docker-php-ext-install curl
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install json
RUN docker-php-ext-install zip
RUN docker-php-ext-install -j$(nproc) intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install gettext
RUN docker-php-ext-install exif

# Enable apache modules
RUN a2enmod rewrite headers

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog