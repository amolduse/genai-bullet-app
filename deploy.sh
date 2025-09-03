#!/bin/bash

# Stop on any error
set -e

echo "🚀 Deploying GenAI Bullet App to AWS Ubuntu Server"
echo "=================================================================="

# Check for GENAI_API_KEY
if [ -z "$GENAI_API_KEY" ]; then
  echo "🛑 GENAI_API_KEY environment variable is not set."
  echo "   Please set it before running this script:"
  echo "   export GENAI_API_KEY='your_api_key'"
  exit 1
fi

# App settings
APP_DIR="/var/www/genai-bullet-app"
USER="ubuntu"

# Update system
echo "📦 Updating system packages..."
sudo apt-get update && sudo apt-get upgrade -y

# Install required packages
echo "🔧 Installing required packages..."
sudo apt-get install -y python3 python3-pip python3-venv nginx build-essential python3-dev

# Create application directory
echo "📁 Setting up application directory..."
sudo mkdir -p $APP_DIR
sudo chown $USER:$USER $APP_DIR

# Copy application files
echo "🚚 Copying application files..."
sudo cp -r app.py requirements.txt gunicorn.conf.py index.html script.js $APP_DIR/
sudo chown -R $USER:$USER $APP_DIR

# Create virtual environment and install dependencies
echo "🐍 Setting up Python virtual environment..."
cd $APP_DIR
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
deactivate

# Create environment file
echo "🔑 Creating environment file..."
sudo tee $APP_DIR/.env > /dev/null <<EOF
GENAI_API_KEY=$GENAI_API_KEY
EOF

# Create systemd service file
echo "⚙️ Creating systemd service..."
sudo tee /etc/systemd/system/genai-bullet-app.service > /dev/null <<EOF
[Unit]
Description=GenAI Bullet App Flask App
After=network.target

[Service]
User=$USER
Group=$USER
WorkingDirectory=$APP_DIR
EnvironmentFile=$APP_DIR/.env
ExecStart=$APP_DIR/venv/bin/gunicorn -c gunicorn.conf.py app:app
Restart=always
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

# Configure Nginx
echo "🌐 Configuring Nginx..."
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

# Enable site and restart services
echo "🔄 Enabling services..."
sudo ln -sf /etc/nginx/sites-available/genai-bullet-app /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo systemctl daemon-reload
sudo systemctl enable genai-bullet-app
sudo systemctl start genai-bullet-app
sudo systemctl restart nginx

# Check status
echo "✅ Checking service status..."
sudo systemctl status genai-bullet-app --no-pager
sudo systemctl status nginx --no-pager

echo ""
echo "🎉 Deployment completed!"
echo "🌐 Your app should now be running at: http://$(curl -s ifconfig.me)"
echo "📁 Application directory: $APP_DIR"
echo "📋 Useful commands:"
echo "   - View logs: sudo journalctl -u genai-bullet-app -f"
echo "   - Restart app: sudo systemctl restart genai-bullet-app"
echo "   - Restart nginx: sudo systemctl restart nginx"
echo "   - Stop app: sudo systemctl stop genai-bullet-app"
