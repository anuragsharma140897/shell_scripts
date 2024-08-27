
# Initialize Kubernetes
echo "Initializing Kubernetes with kubeadm..."
kubeadm init
check_status "Failed to initialize Kubernetes with kubeadm"

# Configure kubectl for regular user
echo "Configuring kubectl for regular user..."
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
check_status "Failed to copy Kubernetes config"
sudo chown $(id -u):$(id -g) $HOME/.kube/config
check_status "Failed to change ownership of Kubernetes config"

# Install Calico for networking
echo "Downloading and applying Calico networking manifest..."
curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/calico.yaml -O
check_status "Failed to download Calico manifest"
kubectl apply -f calico.yaml
check_status "Failed to apply Calico manifest"

echo "Script completed successfully."

