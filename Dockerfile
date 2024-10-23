# Use the official Ubuntu image as the base
FROM ubuntu:22.04

# Set the environment to noninteractive to avoid prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install basic system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    zip \
    vim \
    nano \
    tzdata \
    software-properties-common

# Add PHP repository
RUN add-apt-repository ppa:ondrej/php -y

# Install PHP and necessary extensions
RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-cli \
    php8.2-mbstring \
    php8.2-xml \
    php8.2-zip \
    php8.2-pdo \
    php8.2-mysql \
    php8.2-curl \
    php8.2-bcmath \
    php8.2-gd \
    php8.2-exif

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html/security-company

# Set correct permissions for storage and bootstrap/cache
RUN mkdir -p /var/www/html/security-company/storage /var/www/html/security-company/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/security-company/storage /var/www/html/security-company/bootstrap/cache \
    && chmod -R 775 /var/www/html/security-company/storage /var/www/html/security-company/bootstrap/cache


# Copy existing Laravel application from local to container
COPY . /var/www/html/security-company

# Set correct permissions for .env if it exists
RUN if [ -f /var/www/html/security-company/.env ]; then \
    chown www-data:www-data /var/www/html/security-company/.env && \
    chmod 644 /var/www/html/security-company/.env; \
    fi
    
# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
