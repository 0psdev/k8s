# Defind MINOR_VERSION need to install
KUBE_TAG="v1.33"  <- #version relate with CRI-O

curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBE_TAG/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBE_TAG/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update

# List minor MINOR_VERSION
sudo apt-cache madison kubeadm

# Install K8S
sudo apt-get install -y kubelet=MINOR_VERSION kubeadm=MINOR_VERSION kubectl=MINOR_VERSION  <- *** kubeadm=1.33.5-1.1***

sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet

# Initial Cluster (only controlplan)
sudo kubeadm init --kubernetes-version=1.33.5 \
                  --cri-socket=unix:///var/run/crio/crio.sock \
                  --pod-network-cidr=x.x.x.x \
                  --service-cidr=y.y.y.y \
                  --control-plane-endpoint=name \
                  --cluster-name=mycluster

*** x.x.x.x=network-ip-pod y.y.y.y=network-ip-service name=endpoint-access mycluster=name for cluster (when you have many cluster)***

# Joint worker
sudo kubeadm join ct01.home.local:6443 --token TTTTT --discovery-token-ca-cert-hash sha256:HHHHH 

*** TTTT is value, HHHH is value after intial you can seen or can create new ***

# Make config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

chmod 700 get_helm.sh

./get_helm.sh

# Autocompleate kubectl

sudo apt-get install bash-completion

echo 'source <(kubectl completion bash)' >> ~/.bashrc
source ~/.bashrc
