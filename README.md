# docker-nginx-ssl-companion
Docker Nginx Proxy Let's encrypt companion

# example docker-compose
```yml
version: '2'
services:
  kitten:
    image: ipepe/kitten
  server:
    environment:
    - PROXYPASS_HOST=kitten
    - LETSENCRYPT_EMAIL=letsencrypt@ipepe.pl
    - VIRTUAL_HOSTS=kitten.ipepe.pl
    image: ipepe/nginx-ssl-companion
    ports:
    - "80:80"
    - "443:443"
    links:
    - "kitten"

# docker-compose up
```
