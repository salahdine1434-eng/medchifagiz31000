#!/bin/bash
set -e

# Render injecte le port à écouter via la variable d'environnement PORT
# (10000 par défaut). On reconfigure Apache pour écouter sur ce port.
PORT="${PORT:-10000}"

sed -i "s/Listen 80/Listen ${PORT}/" /etc/apache2/ports.conf
sed -i "s/:80>/:${PORT}>/" /etc/apache2/sites-enabled/000-default.conf

exec "$@"
