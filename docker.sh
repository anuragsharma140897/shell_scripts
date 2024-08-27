
#!/bin/bash

# Function to check the exit status of the last command
check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Script will run in root, so this checks if the user is root or not
if [ "$(id -u)" -ne 0 ]; then
    echo "You are not root. Please run this script as root or with sudo."
    exit 1
fi

# Update and upgrade
echo "Updating and upgrading packages..."
sudo apt update && sudo apt upgrade -y
check_status "Failed to update and upgrade packages"

# Installing Docker
echo "Installing Docker and Docker Compose..."
sudo apt-get install -y docker.io docker-compose
check_status "Failed to install Docker and Docker Compose"

# Add current user to Docker group
echo "Adding $USER to the Docker group..."
sudo usermod -aG docker $USER
check_status "Failed to add user to Docker group"

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
check_status "Failed to start Docker service"
sudo systemctl enable docker
check_status "Failed to enable Docker service"

# Refresh the Docker group membership (optional)
newgrp docker <<'EOF'
echo "Docker group refreshed."
EOF
check_status "Failed to refresh Docker group membership"
