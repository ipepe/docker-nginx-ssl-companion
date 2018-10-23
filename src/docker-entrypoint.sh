#!/usr/bin/env bash

erb /root/default.conf.erb > /etc/nginx/sites-available/default
cat /etc/nginx/sites-available/default

nginx -t

service nginx start
service cron start

bash /root/run-certbot.sh

tail -f /var/log/nginx/access.log
