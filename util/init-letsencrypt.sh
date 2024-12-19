#!/bin/bash

# Check if Apache is running and stop it
if systemctl is-active --quiet apache2; then
    echo "Stopping Apache..."
    sudo systemctl stop apache2
    sudo systemctl disable apache2
    echo "Apache stopped and disabled"
else
    echo "Apache is not running"
fi

domains=(commtact.yuval.guide)
email="your-email@domain.com"  # Replace with your email
staging=0  # Set to 1 if you're testing

# Create required directories
mkdir -p data/certbot/conf
mkdir -p data/certbot/www

# Create temporary nginx config for cert acquisition
cat > nginx/nginx.conf << EOF
[... rest of nginx config ...]
EOF

# Start nginx with temporary config (without watching the logs)
docker compose up -d nginx

# Get initial certificate (without watching the logs)
docker compose run --rm certbot \
    certonly --webroot \
    -w /var/www/certbot \
    --email $email \
    --agree-tos --no-eff-email \
    ${staging:+"--staging"} \
    ${domains[@]/#/-d }

# Replace with full nginx config
cat > nginx/nginx.conf << EOF
[... rest of nginx config ...]
EOF

# Restart everything with the new config (without watching the logs)
docker compose down
docker compose up -d

echo "Setup completed - check logs with 'docker compose logs' if needed"