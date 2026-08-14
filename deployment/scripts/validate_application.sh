#!/bin/bash

set -e

echo "Validating application..."

sleep 3

curl --fail http://localhost:3000/health

echo
echo "Application validation successful."