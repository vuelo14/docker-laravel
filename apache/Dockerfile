# Base image PHP 8.2 dengan Apache
FROM php:8.2-apache

# Update dan instal dependensi sistem yang dibutuhkan untuk ekstensi
RUN apt-get update && apt-get install -y \
    git \
    libzip-dev \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libfreetype6-dev \
    libxml2-dev \
    libpq-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Instal ekstensi PHP (Contoh: mysqli, pdo_mysql, gd, zip, mbstring, exif)
RUN docker-php-ext-install -j$(nproc) \
    bcmath \
    ctype \
    fileinfo \
    openssl \
    tokenizer \
    curl \
    dom \
    mysqli \
    pdo_mysql \
    gd \
    zip \
    mbstring \
    exif \
    xml 
# Tambahkan ekstensi lain yang Anda butuhkan di sini
# Contoh untuk BCMath:
# bcmath \
# Contoh untuk OpCache (perlu konfigurasi php.ini terpisah):
# opcache \
# Contoh untuk soap:
# soap \
# Contoh untuk sockets:
# sockets \
# Contoh untuk intl:
# intl \
# Contoh untuk xsl (membutuhkan libxml2-dev dan libxslt-dev):
# xsl \
# Contoh untuk pdo_pgsql (membutuhkan libpq-dev):
# pdo_pgsql \
# Contoh untuk imagick (lebih kompleks, membutuhkan ImageMagick dan Imagick library)
# pecl install imagick \
# docker-php-ext-enable imagick
# Contoh untuk Redis (membutuhkan phpredis):
# pecl install redis \
# docker-php-ext-enable redis

# Konfigurasi Apache (opsional, untuk mengaktifkan mod_rewrite)
RUN a2enmod rewrite

# Install Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Konfigurasi PHP (opsional: untuk meningkatkan batas memori, dll.)
# Anda bisa membuat php.ini kustom dan meng-copy-nya
# COPY php.ini-production /usr/local/etc/php/php.ini
# Atau tambahkan konfigurasi langsung:
RUN echo "upload_max_filesize = 64M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size = 64M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "memory_limit = 256M" >> /usr/local/etc/php/conf.d/memory.ini \
    && echo "date.timezone = Asia/Jakarta" >> /usr/local/etc/php/conf.d/timezone.ini # Sesuaikan timezone
