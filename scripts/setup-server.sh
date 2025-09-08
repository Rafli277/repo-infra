#!/bin/bash
set -e

# Variables
APP_DIR="/opt/repo-infra"
USER_NAME="devops"

echo "=== 1. Update & install dependencies ==="
apt-get update
apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    unzip

echo "=== 2. Install Docker ==="
if ! command -v docker &> /dev/null; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh get-docker.sh
    rm get-docker.sh
    usermod -aG docker $USER_NAME || echo "Add current user to docker group manually"
fi

echo "=== 3. Install Docker Compose v2 ==="
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.18.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
docker-compose version

echo "=== 4. Setup Docker Compose network & volumes ==="
docker network inspect app-network &>/dev/null || docker network create app-network
docker volume inspect postgres_data &>/dev/null || docker volume create postgres_data

echo "=== Server setup completed! ==="
echo "Project dir: $APP_DIR"
echo "Docker & Docker Compose installed."
