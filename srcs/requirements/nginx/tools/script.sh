# !/bin/sh
if [ ! -f "/etc/nginx/conf.d/default.conf" ]; then
  cp /tmp/default.conf /etc/nginx/conf.d/default.conf
  sleep 5;
fi
nginx -g 'daemon off;'
