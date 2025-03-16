# Gunakan PHP 8.2 dengan Apache
FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan
RUN docker-php-ext-install pdo pdo_mysql

# Copy semua file proyek ke dalam container
COPY . /var/www/html

# Set working directory ke Laravel
WORKDIR /var/www/html

# Pastikan Apache menggunakan `public/`
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# Aktifkan mod_rewrite agar Laravel bisa menangani routing dengan benar
RUN a2enmod rewrite

# Berikan permission agar Laravel bisa berjalan
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Jalankan Apache
CMD ["apache2-foreground"]
