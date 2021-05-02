#!/bin/bash

service php7.3-fpm start
/opt/nginx/sbin/nginx

exec "$@"
