#!/bin/bash
set -e

# Receive blob container URL from Terraform
BLOB_URL=$1

# Update packages
sudo apt update -y

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install PostgreSQL client
sudo apt install -y postgresql-client

# Install PM2
sudo npm install -g pm2

# Create app directory
sudo mkdir -p /student-app
cd /student-app

# Initialize node project
npm init -y

# Install dependencies
npm install express cors body-parser jsonwebtoken bcryptjs dotenv pg

# Download backend files from Azure Blob Storage
wget ${BLOB_URL}/server.js
wget ${BLOB_URL}/db.js
wget ${BLOB_URL}/authMiddleware.js
wget ${BLOB_URL}/.env

# Start backend server
pm2 start server.js

# Configure PM2 to start on VM boot
pm2 startup
pm2 save
