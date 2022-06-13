FROM alpine:3.13

# Package Installation
RUN apk update && apk upgrade && apk add \
	curl \
	mariadb-client \
	php7 \
	php7-phar \
	php7-json \
	php7-curl \
	php7-fpm \
	php7-mysqli \
	php7-iconv \
	dumb-init
RUN chmod +x /usr/bin/dumb-init

RUN mkdir -p /var/www/wordpress
RUN curl -s -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp
RUN chmod +x /usr/bin/wp
RUN wp core download --version=5.8.1 --path=/var/www/wordpress

# Copy Files
COPY        conf/wp-config.php /tmp/wp-config.php
COPY        tools/script.sh /tmp/script.sh

# Permission Control
RUN         chmod +x /tmp/script.sh

# Handle Every Signal Correctly by Dumb Init to PID 1
ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]

# Command to Execute by Entrypoint
CMD         [ "sh", "-c", "/tmp/script.sh" ]
