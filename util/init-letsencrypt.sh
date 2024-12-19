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
events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        server_name commtact.yuval.guide;

        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }

        location / {
            return 200 'Temporary config for SSL setup';
        }
    }
}
EOF

# Start nginx with temporary config
docker compose up -d nginx

# Get initial certificate
docker compose run --rm certbot \
    certonly --webroot \
    -w /var/www/certbot \
    --email $email \
    --agree-tos --no-eff-email \
    ${staging:+"--staging"} \
    ${domains[@]/#/-d }

# Replace with full nginx config
cat > nginx/nginx.conf << EOF
events {
    worker_connections 1024;
}

http {
    server {
        listen 80;
        server_name commtact.yuval.guide;

        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }

        location / {
            return 301 https://\$host\$request_uri;
        }
    }

    server {
        listen 443 ssl;
        server_name commtact.yuval.guide;

        ssl_certificate /etc/letsencrypt/live/commtact.yuval.guide/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/commtact.yuval.guide/privkey.pem;

        location / {
            proxy_pass http://jupyterhub:8000;
            proxy_set_header X-Real-IP \$remote_addr;
            proxy_set_header Host \$host;
            proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto \$scheme;

            # WebSocket support
            proxy_http_version 1.1;
            proxy_set_header Upgrade \$http_upgrade;
            proxy_set_header Connection "upgrade";
        }
    }
}
EOF

# Restart everything with the new config
docker compose down
docker compose up -d

echo "Setup completed"