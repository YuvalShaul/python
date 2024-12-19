#!/bin/bash
set -x

# Stop running containers first
docker compose down

# Stop Apache if running
if systemctl is-active --quiet apache2; then
    echo "Stopping Apache..."
    sudo systemctl stop apache2
    sudo systemctl disable apache2
fi

# Install certbot
sudo apt update
sudo apt install -y certbot

# Get the certificate
sudo certbot certonly --standalone \
    -d commtact.yuval.guide \
    --email your-email@domain.com \
    --agree-tos \
    --non-interactive

# Start your regular docker compose setup with HTTPS config
cp nginx/nginx.https.conf nginx/nginx.conf

echo "Setup completed"