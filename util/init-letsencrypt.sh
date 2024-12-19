#!/bin/bash

# Check if Apache is running and stop it
if systemctl is-active --quiet apache2; then
    echo "Stopping Apache..."
    sudo systemctl stop apache2
    sudo systemctl disable apache2
    echo "Apache is not running"
fi

domains=(commtact.yuval.guide)
email="your-email@domain.com"  # Replace with your email
staging=0  # Set to 1 if you're testing

# Create required directories
mkdir -p data/certbot/conf
mkdir -p data/certbot/www

# Use HTTP-only config
cp nginx/nginx.http.conf nginx/nginx.conf

# Start nginx with HTTP config
docker compose up -d nginx

# Get initial certificate
docker compose run --rm certbot \
    certonly --webroot \
    -w /var/www/certbot \
    --email $email \
    --agree-tos --no-eff-email \
    ${staging:+"--staging"} \
    ${domains[@]/#/-d }

# Switch to HTTPS config
cp nginx/nginx.https.conf nginx/nginx.conf

# Restart everything with the new config
docker compose down
docker compose up -d

echo "Setup completed"