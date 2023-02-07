#!/bin/sh

sudo apt-get install apache2-utils -y
touch ./traefik/conf/acme.json && chmod 600 ./traefik/conf/acme.json && \
cp ./.env.exemple ./.env && \
cp ./traefik/conf/traefik.exemple ./traefik/conf/traefik.yml && \
echo "1. Run -- make -e user=your_user basic-auth-pwd" && \
echo "2. Edit your .env with your own information" && \
echo "3. Edit your ./traefik/conf/traefik.toml with your own information"