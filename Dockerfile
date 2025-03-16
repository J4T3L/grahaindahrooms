# Gunakan PHP 8.2 dengan Apache
FROM php:8.2-apache

# Install ekstensi PHP yang dibutuhkan
RUN docker-php-ext-install pdo pdo_mysql

# Set working directory ke Laravel
WORKDIR /var/www/html

# Copy semua file proyek ke dalam container
COPY . .

# Install Composer dan dependensi Laravel
RUN apt-get update && apt-get install -y unzip curl mariadb-client \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-dev --optimize-autoloader

# Pastikan Apache menggunakan `public/`
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
    && sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# Aktifkan mod_rewrite agar Laravel bisa menangani routing dengan benar
RUN a2enmod rewrite

# Berikan permission agar Laravel bisa berjalan
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html

# Import database saat container pertama kali berjalan
COPY ./public/indonesia.sql /tmp/dbkp2.sql 
RUN ["bash", "-c", "mysql -h $DB_HOST -u$DB_USERNAME -p$DB_PASSWORD $DB_DATABASE < /tmp/database.sql || echo 'Database import skipped'"]

# Expose port 80
EXPOSE 80

# Jalankan Apache
CMD ["apache2-foreground"]
