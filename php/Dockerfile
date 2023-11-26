FROM php:8.1-fpm as BUILD

ENV APACHE_DOCUMENT_ROOT /var/www
#Copy composer.lock and composer.json  /
COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /var/www

# Install dependencies
RUN apt-get update \
    && apt-get install --yes -q --no-install-recommends \
	autoconf \
	apt-utils \
	build-essential \
	libpng-dev \
	libpng-dev \
	libjpeg62-turbo-dev \
	libfreetype6-dev \
	libcurl4-openssl-dev \
	libxml2-dev \
	libzip-dev \
	libicu-dev \
	locales \
	libmagick++-dev \
	libmagickwand-dev \
	libpq-dev \
	zip \
	unzip \
	libxpm-dev \
	jpegoptim optipng pngquant gifsicle \
	vim \
	unzip \
	git \
	libonig-dev \
	curl \
	gnupg2 \
	ca-certificates \
	apt-transport-https \
	libmemcached-dev libssl-dev zlib1g-dev

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
	#docker-php-ext-install -j "$(nproc)" \
	#	bcmath \
	#	intl \
	#	pcntl \
	#	pdo_mysql \
	#	sysvsem \
	#	exif \
	#	opcache \
	#	pdo_pgsql

# Clear cache


VOLUME /var/www
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg 

# Install extensions
#RUN docker-php-ext-enable memcached
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl intl mysqli gd bcmath
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ #--with-png=/usr/include/
RUN pecl install imagick-3.4.3
RUN docker-php-ext-configure zip --with-libzip
#RUN docker-php-ext-enable xdebug


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clear package lists
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

ENV PHP_MEMORY_LIMIT 512M
ENV PHP_UPLOAD_LIMIT 512M

# Add user for laravel application
RUN groupadd -g 1000 www-user
RUN useradd -u 1000 -ms /bin/bash -g www-user www-user

# Add user for server application
RUN groupadd -g 1001 ubuntu
RUN useradd -u 1001 --home /home/ubuntu -ms /bin/bash -g ubuntu ubuntu
RUN usermod -aG sudo ubuntu


# Permissions
RUN chown -R ubuntu:www-use /var/www
RUN chmod u+rwx,g+rx,o+rx /var/www
RUN find /var/www -type d -exec chmod u+rwx,g+rx,o+rx {} +
RUN find /var/www -type f -exec chmod u+rw,g+rw,o+r {} +

# Copy existing application directory contents
COPY . /var/www
COPY app /var/www
# Copy existing application directory permissions
COPY --chown=www-user:www-user . /var/www
COPY --chown=www-user:www-user app /var/www

WORKDIR /var/www/app

VOLUME ["/var/www/app"]
# Change current user to www-user
USER www-user

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]

# Change current user to ubuntu
USER ubuntu

EXPOSE 80 443
# Expose port 443 80 and start apache server

