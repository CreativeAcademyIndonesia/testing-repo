# 1. Pakai image resmi PHP 8.2 dengan FPM
FROM php:8.2-fpm

# 2. Update package list dan install dependency yang dibutuhkan Laravel
RUN apt-get update && apt-get install -y \
    git curl zip unzip libpq-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring tokenizer xml

# 3. Ambil file composer dari image resmi composer dan copy ke container kita.
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# 4. Set direktori kerja di dalam container
WORKDIR /var/www/html

# 5. Copy semua file Laravel ke dalam container
COPY . .

# 6. Install dependency Laravel (hanya untuk production: tanpa dev)
RUN composer install --no-dev --optimize-autoloader

# 7. Optimasi Laravel: cache config, route, dan view
RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# 8. Atur permission supaya storage & cache bisa diakses web server
RUN chown -R www-data:www-data storage bootstrap/cache

# 9. Expose port 9000 (PHP-FPM listen di port ini)
EXPOSE 9000

# 10. Perintah default saat container jalan: jalankan php-fpm
CMD ["php-fpm"]
