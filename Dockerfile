FROM php:7.4-apache

# Install necessary packages and PHP extensions
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    default-mysql-client \
    git \
    unzip \
    libcurl4-gnutls-dev \
    libicu-dev \
    libmcrypt-dev \
    libvpx-dev \
    libjpeg-dev \
    libpng-dev \
    libxpm-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libxml2-dev \
    libexpat1-dev \
    libbz2-dev \
    libgmp3-dev \
    libc-client-dev \
    libkrb5-dev \
    libssl-dev \
    libzip-dev \
    libonig-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-jpeg --with-freetype; \
    docker-php-ext-install gd mbstring xml zip mysqli pdo_mysql

# Enable apache mods.
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Drush 8 using Composer
RUN composer global require drush/drush:^8.0

# Add Composer's global bin directory to the PATH
ENV PATH="/root/.composer/vendor/bin:${PATH}"

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
RUN echo "short_open_tag = On" >> /usr/local/etc/php/php.ini
RUN echo "error_reporting = E_ERROR | E_WARNING | E_PARSE" >> /usr/local/etc/php/php.ini

# Expose apache.
EXPOSE 80

# Copy your Drupal site into place.
COPY public_html /var/www/html

# Set file permissions
RUN chown -R www-data:www-data /var/www/html
RUN find /var/www/html -type d -exec chmod 755 {} \;
RUN find /var/www/html -type f -exec chmod 644 {} \;

# By default, start up apache in the foreground. Override with /bin/bash for interactive.
CMD ["apache2-foreground"]
