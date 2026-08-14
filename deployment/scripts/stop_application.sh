#!/bin/bash

set -e

APP_DIR="/opt/aws-cicd/application"

if [ -f "$APP_DIR/app.pid" ]; then
    PID=$(cat "$APP_DIR/app.pid")

    if kill -0 "$PID" 2>/dev/null; then
        echo "Stopping application process: $PID"
        kill "$PID"
    fi

    rm -f "$APP_DIR/app.pid"
fi

echo "Application stopped."