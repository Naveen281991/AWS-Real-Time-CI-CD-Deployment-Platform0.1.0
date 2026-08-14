#!/bin/bash

set -e

APP_DIR="/opt/aws-cicd/application"

cd "$APP_DIR"

echo "Starting Node.js application..."

nohup npm start > "$APP_DIR/application.log" 2>&1 &

echo $! > "$APP_DIR/app.pid"

echo "Application started with PID $(cat "$APP_DIR/app.pid")"