# Alpine Linux is used for containers because of the lightweight
# https://www.alpinelinux.org/
FROM alpine:3.13

# apk is Alpine Package Keeper

# mariadb is db server
# mariadb-10.5.16-r0 x86_64 {mariadb} (GPL-2.0-or-later) [installed]
# https://mariadb.org/
# https://mariadb.org/documentation/

# mariadb-client is for cli
# mariadb-client-10.5.16-r0 x86_64 {mariadb} (GPL-2.0-or-later) [installed]
# https://mariadb.com/docs/connect/clients/mariadb-client/
RUN apk update && apk add \
	mariadb \
	mariadb-client

# dumb-init for PID 1 handling signal
# https://github.com/Yelp/dumb-init
RUN wget -O /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod +x /usr/bin/dumb-init

# mariadb-install-db: Init mariadb and create system table
# --datadir=
# --auth-root-authentication-method={normal | socker}
# https://mariadb.com/kb/en/mysql_install_db/
RUN mkdir -p /run/mysqld /var/lib/mysql
RUN mariadb-install-db \
	--datadir=/var/lib/mysql \
	--auth-root-authentication-method=normal
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY conf/query.sql /tmp/query.sql
COPY tools/script.sh /tmp/script.sh

RUN chmod +x /tmp/script.sh

# Runs "/usr/bin/dumb-init -- /my/script --with --args"
ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]

# or if you use --rewrite or other cli flags
# ENTRYPOINT ["dumb-init", "--rewrite", "2:3", "--"]
CMD         [ "sh", "-c", "/tmp/script.sh" ]
