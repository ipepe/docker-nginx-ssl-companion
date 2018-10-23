#!/usr/bin/env bash

if [ "$LETSENCRYPT_EMAIL" = "example@example.org" ]; then
    certbot --nginx --agree-tos --register-unsafely-without-email -d "$VIRTUAL_HOSTS"
else
    certbot --nginx --agree-tos -m "$LETSENCRYPT_EMAIL" -d "$VIRTUAL_HOSTS"
fi