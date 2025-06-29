# Gunakan image dasar PHP 8.2 Apache
FROM php:8.2-apache

# Instal dependensi yang diperlukan untuk ekstensi PHP
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype-dev \
    libwebp-dev \
    && rm -rf /var/lib/apt/lists/*

# Instal ekstensi PHP yang dibutuhkan Laravel 10
# Menggunakan docker-php-ext-install untuk ekstensi bawaan PHP
# Menggunakan pecl install untuk ekstensi seperti imagick jika dibutuhkan
RUN docker-php-ext-install -j$(nproc) \
    bcmath \
    ctype \
    fileinfo \
    mbstring \
    openssl \
    pdo_mysql \
    tokenizer \
    xml \
    curl \
    dom \
    gd \
    zip

# (Opsional) Jika Anda menggunakan imagick
# RUN pecl install imagick \
#    && docker-php-ext-enable imagick

# (Opsional) Jika Anda perlu mengaktifkan mod_rewrite Apache
RUN a2enmod rewrite

# Salin kode aplikasi Laravel ke dalam container
# Pastikan Anda mengatur workdir ke /var/www/html atau lokasi aplikasi Anda
WORKDIR /var/www/html

# Copy your Laravel application code
# COPY . /var/www/html/

# Atur hak akses yang sesuai untuk direktori penyimpanan dan cache Laravel
# Ini sangat penting agar Laravel bisa menulis ke direktori ini
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port (biasanya port 80 untuk Apache)
EXPOSE 80

# Command to run Apache when the container starts
CMD ["apache2-foreground"]
