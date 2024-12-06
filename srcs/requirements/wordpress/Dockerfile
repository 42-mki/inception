FROM alpine:3.13

# Package installation for wp-cli
# 
# curl: download wp-cli
# mariadb-client: for connecting mariadbd
# php7: php interpreter
# php7-fpm:
# php7-phar: php archive
# php7-json:
# php7-curl:
# php7-mysqli:
# php7-iconv:
RUN apk update && apk upgrade && apk add \
	curl \
	mariadb-client \
	php7 \
	php7-fpm \
	php7-phar \
	php7-json \
	php7-curl \
	php7-mysqli \
	php7-iconv

# Download wp-cli by curl
# Change mode to execute
# wp-cli docs: https://developer.wordpress.org/cli/commands/core/download/
RUN curl -s -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp
RUN chmod +x /usr/bin/wp
RUN mkdir -p /var/www/wordpress
RUN wp core download --version=5.8.1 --path=/var/www/wordpress

# Copy configuration files
# Change mode to execute
COPY conf/wp-config.php /tmp/wp-config.php
COPY tools/script.sh /tmp/script.sh
RUN chmod +x /tmp/script.sh

# Add dumb-init for init process
RUN apk add dumb-init
RUN chmod +x /usr/bin/dumb-init
ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "sh", "-c", "/tmp/script.sh" ]
