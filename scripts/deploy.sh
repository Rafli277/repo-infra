#!/bin/bash

# Deployment script for the full stack
set -e

echo "🚀 Starting deployment..."

# Check if specific service should be deployed
if [ "$1" = "frontend" ]; then
    echo "📦 Deploying Frontend only..."
    docker-compose pull frontend
    docker-compose up -d --no-deps frontend
elif [ "$1" = "backend" ]; then
    echo "📦 Deploying Backend only..."
    docker-compose pull backend
    docker-compose up -d --no-deps backend
elif [ "$1" = "nginx" ]; then
    echo "📦 Deploying Nginx only..."
    docker-compose pull nginx
    docker-compose up -d --no-deps nginx
else
    echo "📦 Deploying full stack..."
    docker-compose pull
    docker-compose down
    docker-compose up -d
fi

# Clean up
echo "🧹 Cleaning up old images..."
docker image prune -af

echo "✅ Deployment completed successfully!"
echo "🌐 Application: http://localhost"
echo "🔧 API: http://localhost/api"
echo "📊 Health: http://localhost/health"