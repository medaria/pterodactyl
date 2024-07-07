#!/bin/bash
set -e

# NGINX starten
nginx -g "daemon off;"

# Optional: PHP-FPM starten
php-fpm8.3 -F
