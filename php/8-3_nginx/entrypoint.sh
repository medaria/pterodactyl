#!/bin/bash
# Entry point script to start PHP-FPM and Nginx

# Start PHP-FPM
php-fpm8.3

# Start Nginx
nginx -g "daemon off;"
