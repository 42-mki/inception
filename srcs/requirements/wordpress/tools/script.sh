# !/bin/sh

grep -E "listen = 127.0.0.1" /etc/php7/php-fpm.d/www.conf > /dev/null 2>&1
if [ $? -eq 0 ]; then
  sed -i "s/.*listen = 127.0.0.1.*/listen = 9000/g" /etc/php7/php-fpm.d/www.conf
  echo "env[MARIADB_HOST] = \$MARIADB_HOST" >> /etc/php7/php-fpm.d/www.conf
  echo "env[MARIADB_USER] = \$MARIADB_USER" >> /etc/php7/php-fpm.d/www.conf
  echo "env[MARIADB_PASSWORD] = \$MARIADB_PASSWORD" >> /etc/php7/php-fpm.d/www.conf
  echo "env[MARIADB_DB] = \$MARIADB_DB" >> /etc/php7/php-fpm.d/www.conf
fi

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
  cp /tmp/wp-config.php /var/www/wordpress/wp-config.php
  sleep 5;
  # Check Whether Database Server is Alive or Not
  # https://dev.mysql.com/doc/refman/8.0/en/mysqladmin.html
  # mysqladmin ping
  #  --host=host_name, -h host_name
  #  --user=user_name, -u user_name
  #  --password[=password], -p[password]
  #  --wait[=count], -w[count]
  if ! mysqladmin \
	  -h $MARIADB_HOST \
	  -u $MARIADB_USER \
	  --password=$MARIADB_PASSWORD \
	  --wait=60 \
	  ping > /dev/null; then
    printf "MariaDB Daemon Unreachable\n"
    exit 1
  fi

  # wp core install: https://developer.wordpress.org/cli/commands/core/install/
  # wp plugin update: https://developer.wordpress.org/cli/commands/plugin/update/
  # wp user create: https://developer.wordpress.org/cli/commands/user/create/
  wp core install \
	  --url="$WORDPRESS_URL" \
	  --title="$WORDPRESS_TITLE" \
	  --admin_user="$WORDPRESS_ADMIN_USER" \
	  --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
	  --admin_email="$WORDPRESS_ADMIN_EMAIL" \
	  --skip-email --path=/var/www/wordpress
  wp plugin update \
	  --all \
	  --path=/var/www/wordpress
  wp user create \
	  $WORDPRESS_USER \
	  $WORDPRESS_USER_EMAIL \
	  --role=author \
	  --user_pass=$WORDPRESS_USER_PASSWORD \
	  --path=/var/www/wordpress
fi

# 7 FastCGI sent in stderr: "PHP message: PHP Warning: Unknown: failed to open stream: Permission denied in Unknown on line 0Unable to open primary script: /var/www/html/index.php (Permission denied)" while reading response header from upstream
chmod 777 -R /var/www/wordpress

# Run by Dumb Init
# https://linux.die.net/man/8/php-fpm
# port 9000
php-fpm7 --nodaemonize
