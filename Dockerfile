# Gunakan PHP 8.2 sebagai base image
FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan
RUN docker-php-ext-install pdo pdo_mysql

# Copy semua file proyek ke dalam container
COPY . /var/www/html

# Set working directory ke folder proyek
WORKDIR /var/www/html

# Berikan permission agar Laravel bisa berjalan
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80

# Jalankan Apache
CMD ["apache2-foreground"]
