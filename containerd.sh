#!/bin/bash

# Update the package list
apt update

# Install containerd and apt-transport-https
apt install -y containerd apt-transport-https

# Create the /etc/containerd directory if it doesn't already exist
mkdir -p /etc/containerd

# Generate the default containerd configuration file
containerd config default > /etc/containerd/config.toml

# Restart containerd to apply the new configuration
systemctl restart containerd

# Enable containerd to start on boot
systemctl enable containerd

