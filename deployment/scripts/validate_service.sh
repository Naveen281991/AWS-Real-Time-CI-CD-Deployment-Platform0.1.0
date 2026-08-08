#!/bin/bash

set -e

echo "Validating application health..."

for i in {1..10}; do
    if curl --fail --silent http://localhost:3000/health > /dev/null; then
        echo "Health check successful."
        exit 0
    fi

    echo "Application not ready yet. Retrying..."
    sleep 3
done

echo "Health check failed."
exit 1