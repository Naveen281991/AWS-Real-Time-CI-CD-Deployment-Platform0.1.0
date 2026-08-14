#!/bin/bash

set -e

APP_DIR="/opt/aws-cicd/application"

cd "$APP_DIR"

echo "Installing Node.js dependencies..."

npm ci --omit=dev

echo "Dependencies installed."