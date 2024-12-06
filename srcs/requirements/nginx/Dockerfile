FROM alpine:3.13

RUN apk update && apk upgrade && apk add \
	nginx \
	openssl \
	dumb-init
RUN chmod +x /usr/bin/dumb-init

RUN mkdir -p /etc/nginx/tls /var/run/nginx

RUN openssl req \
	-new \
	-newkey rsa:4096 \
	-x509 \
	-sha256 \
	-days 365 \
	-nodes \
	-out /etc/nginx/tls/mki.42.fr.crt \
	-keyout /etc/nginx/tls/mki.42.fr.key \
	-subj "/C=KR/ST=Seoul/L=Songpa-gu/O=42/OU=42Seoul/CN=mki.42.fr"

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN rm -rf /etc/nginx/conf.d/default.conf

COPY        conf/default.conf /tmp/default.conf
COPY        tools/script.sh /tmp/script.sh

RUN         chmod +x /tmp/script.sh
EXPOSE      443

ENTRYPOINT  [ "/usr/bin/dumb-init", "--" ]
CMD         [ "sh", "-c", "/tmp/script.sh" ]
