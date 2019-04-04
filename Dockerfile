FROM ubuntu:18.04
MAINTAINER docker@ipepe.pl

COPY src /root

RUN apt-get update 
RUN apt-get install -y software-properties-common 
RUN add-apt-repository ppa:certbot/certbot 
RUN apt-get update 
RUN apt-get install -y ruby cron nginx python-certbot-nginx nano
RUN mkdir -p /etc/nginx/certs 
RUN openssl req -x509 -newkey rsa:4096 \
        -keyout /etc/nginx/certs/default.key \
        -out /etc/nginx/certs/default.crt \
        -days 2048 -subj '/CN=localhost' -nodes
RUN chmod +x /root/docker-entrypoint.sh 
RUN chmod +x /root/run-certbot.sh 
RUN ln -s /root/run-certbot.sh /etc/cron.daily/run-certbot.sh 
RUN cp /root/letsencrypt.conf /etc/nginx/conf.d/letsencrypt.conf
RUN mkdir -p /var/www/_letsencrypt
RUN chown www-data:www-data /var/www/_letsencrypt

ENV VIRTUAL_HOSTS=localhost PROXYPASS_HOST=localhost PROXYPASS_PROTOCOL=http LETSENCRYPT_EMAIL=example@example.org

CMD ["/root/docker-entrypoint.sh"]
