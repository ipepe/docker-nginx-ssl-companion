FROM ubuntu:18.04
MAINTAINER docker@ipepe.pl

COPY src /root

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get update && \
    apt-get install -y ruby cron nginx python-certbot-nginx nano && \
    mkdir -p /etc/nginx/certs && \
    openssl req -x509 -newkey rsa:4096 \
    -keyout /etc/nginx/certs/default.key \
    -out /etc/nginx/certs/default.crt \
    -days 2048 -subj '/CN=localhost' -nodes && \
    chmod +x /root/docker-entrypoint.sh

ENV VIRTUAL_HOSTS=localhost PROXYPASS_HOST=localhost PROXYPASS_PROTOCOL=http LETSENCRYPT_EMAIL=example@example.org

CMD ["/root/docker-entrypoint.sh"]