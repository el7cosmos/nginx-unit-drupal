ARG UNIT_VERSION
ARG PHP_VERSION

FROM unit:${UNIT_VERSION}-php${PHP_VERSION}

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# install the PHP extensions we need
RUN install-php-extensions \
		gd \
		opcache \
		pdo_mysql \
		pdo_pgsql \
		zip \
	; \
	\
#	Use the default production configuration
	mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Override with custom opcache settings
COPY opcache-recommended.ini ${PHP_INI_DIR}/conf.d/

COPY config.json /docker-entrypoint.d/

WORKDIR /opt/drupal
