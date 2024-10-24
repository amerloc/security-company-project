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

# Expose port 9000
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
