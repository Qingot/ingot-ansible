FROM php:8.1-fpm

#ENV APACHE_DOCUMENT_ROOT /var/www/html
# Copy composer.lock and composer.json
#COPY composer.lock composer.json /var/www/html

# Set working directory
WORKDIR /var/www/html

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
	#docker-php-ext-install -j "$(nproc)" \
	#	bcmath \
	#	intl \
	#	pcntl \
	#	pdo_mysql \
	#	sysvsem \
	#	exif \
	#	opcache \
	#	pdo_pgsql

# Clear cacheq
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

VOLUME /var/www/html
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg 
# Install extensions
#RUN docker-php-ext-enable memcached
RUN docker-php-ext-install pdo_mysql mbstring zip exif pcntl intl mysqli gd bcmath
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ #--with-png=/usr/include/
RUN pecl install imagick-3.4.3
#RUN docker-php-ext-enable xdebug
#RUN docker-php-ext-configure zip --with-libzip

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Clear package lists
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

ENV PHP_MEMORY_LIMIT 512M
ENV PHP_UPLOAD_LIMIT 512M

# Add user for laravel application
RUN groupadd -g 1000 www-use
RUN useradd -u 1000 -ms /bin/bash -g www-use www-use

# Permissions
RUN chown -R root:www-use /var/www/html
RUN chmod u+rwx,g+rx,o+rx /var/www/html
RUN find /var/www/html -type d -exec chmod u+rwx,g+rx,o+rx {} +
RUN find /var/www/html -type f -exec chmod u+rw,g+rw,o+r {} +

# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www-use:www-use . /var/www/html

# Change current user to www-user
USER www-use

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
