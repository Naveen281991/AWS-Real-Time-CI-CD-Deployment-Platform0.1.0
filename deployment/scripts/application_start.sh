#!/bin/bash

set -e

APP_DIR="/opt/aws-cicd-application/application"

echo "Starting AWS Enterprise CI/CD application..."

cd "$APP_DIR"

npm install --omit=dev

pkill -f "node src/server.js" || true

nohup node src/server.js > /var/log/aws-cicd-application.log 2>&1 &

echo "Application started successfully."