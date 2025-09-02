#!/bin/bash
# filepath: d:\learn-ai\genai-bullet-app\deploy.sh

set -e

# Update system and install dependencies
sudo apt update
sudo apt install -y python3-pip python3-venv nginx

# Setup Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
pip install --upgrade pip
pip install flask gunicorn google-genai

# Set your GenAI API key (replace with your actual key)
export GENAI_API_KEY="your-genai-api-key"

# Start Gunicorn (use systemd for production, see below)
nohup gunicorn --bind 127.0.0.1:5000 app:app &

# Configure Nginx reverse proxy
sudo tee /etc/nginx/sites-available/genai-bullet-app > /dev/null <<EOF
server {
    listen 80;
    server_name _;
    location / {
        proxy_pass http://127.0.0.1:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/genai-bullet-app /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

echo "App deployed! Visit your server's public IP in a browser."