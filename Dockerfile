# Gunakan base image PHP + Apache
FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    zip unzip git curl libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring gd

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory di dalam container
WORKDIR /var/www/html

# Copy semua file ke dalam container
COPY . .

# Install dependensi Laravel
RUN composer install --no-dev --optimize-autoloader

# Beri izin ke storage dan bootstrap
RUN chmod -R 777 storage bootstrap/cache

# Expose port 80 untuk Apache
EXPOSE 80

# Jalankan Laravel dengan Apache
CMD ["apache2-foreground"]
