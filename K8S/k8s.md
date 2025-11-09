# Defind version need to install
KUBE_TAG="v1.33"

curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBE_TAG/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBE_TAG/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

# List minor version
sudo apt-cache madison kubeadm

# Instll K8S
sudo apt-get install -y kubelet=VERSION kubeadm=VERSION kubectl=VERSION

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet
