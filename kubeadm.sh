
# Install Kubernetes
echo "Disabling swap..."
sudo swapoff -a
check_status "Failed to disable swap"

echo "Updating the apt package index and installing required packages..."
sudo apt-get update
check_status "Failed to update package index"
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg
check_status "Failed to install packages required for Kubernetes"

echo "Downloading the Kubernetes public signing key..."
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
check_status "Failed to download the Kubernetes public signing key"

echo "Adding the Kubernetes repository..."
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
check_status "Failed to add the Kubernetes repository"

echo "Installing kubelet, kubeadm, and kubectl..."
sudo apt-get update
check_status "Failed to update package index"
sudo apt-get install -y kubelet kubeadm kubectl
check_status "Failed to install kubelet, kubeadm, and kubectl"
sudo apt-mark hold kubelet kubeadm kubectl
check_status "Failed to mark Kubernetes packages on hold"

# Enable kubelet
echo "Enabling and starting kubelet..."
sudo systemctl enable --now kubelet
check_status "Failed to enable and start kubelet"
