FROM php:8.4-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpq-dev libonig-dev libxml2-dev libzip-dev \
    nodejs npm \
    && docker-php-ext-install pdo pdo_mysql


RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install intl

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Install Symfony CLI (optional but useful)
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony*/bin/symfony /usr/local/bin/symfony

# Create app directory
WORKDIR /var/www/app

# Copy project files
COPY app/composer.json app/package.json ./

# Install PHP deps
RUN composer install --no-interaction

# Permissions
RUN chown -R www-data:www-data /var/www/app

# Install JS deps (Encore/Vue)
RUN #npm install

RUN #npm run build

# Expose port if needed (e.g., for Symfony CLI server or nginx)
#EXPOSE 8000
EXPOSE 80

# Start PHP-FPM
CMD ["php-fpm"]
