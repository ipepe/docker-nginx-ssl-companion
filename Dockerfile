FROM ubuntu:18.04
MAINTAINER docker@ipepe.pl

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:certbot/certbot && \
    apt-get update && \
    apt-get install -y ruby cron nginx python-certbot-nginx nano

RUN mkdir -p /etc/nginx/certs && \
    openssl req -x509 -newkey rsa:4096 \
    -keyout /etc/nginx/certs/default.key \
    -out /etc/nginx/certs/default.crt \
    -days 2048 -subj '/CN=localhost' -nodes

ENV VIRTUAL_HOSTS=localhost
ENV PROXYPASS_HOST=localhost
ENV PROXYPASS_PROTOCOL=http
ENV LETSENCRYPT_EMAIL=example@example.org

COPY src /root
RUN chmod +x /root/docker-entrypoint.sh
CMD ["/root/docker-entrypoint.sh"]