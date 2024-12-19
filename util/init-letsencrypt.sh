#!/bin/bash

domains=(commtact.yuval.guide)
email="your-email@domain.com"  # Replace with your email
staging=0  # Set to 1 if you're testing

# Create required directories
mkdir -p data/certbot/conf
mkdir -p data/certbot/www

# Stop existing containers
docker compose down

# Get initial certificate
docker compose run --rm certbot \
    certonly --webroot \
    -w /var/www/certbot \
    --email $email \
    --agree-tos --no-eff-email \
    ${staging:+"--staging"} \
    ${domains[@]/#/-d }

# Start services
docker compose up -d