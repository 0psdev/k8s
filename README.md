# How to install K8S
Basic Kubernetes (K8S) installation in a small environment that’s practical enough to be used in real scenarios.

# 🔧 Stack
- OS: Ubuntu
- Container Runtime: CRI‑O
- Cluster Tooling: kubeadm
- CNI Plugin: Calico

# 🎯 Propose
1. For basic learning and hands‑on practice.
2. For proof of concept (POC) in office environments.
3. For small workloads (on‑premise setups may require a load balancer when exposing services).

# 🪜 Step
1. Prepare your host before installing software -> [HOST](https://github.com/0psdev/k8s/blob/main/Host/prepare.sh)
2. Install container runtime (using CRI-O) -> [CRIO](https://github.com/0psdev/k8s/blob/main/CRI-O/crio.sh)
3. Install K8S (using kubeadm) -> [K8S](https://github.com/0psdev/k8s/blob/main/K8S/k8s.md)
4. Install CNI plugin (calico) -> [CNI](https://github.com/0psdev/k8s/blob/main/CNI/calico.md)
5. Install Metrics Server (kubeclt top)

# Firewall rule Controlplan

ufw allow 6443/tcp <- Kubernetes API server

ufw allow 10250/tcp <- Kubelet

ufw allow 4789/udp <- Calico VXLAN overlay

ufw allow 5473/tcp <- Calico Typha

ufw allow in on eth0 to any port 4789 proto udp

# Firewall rule wokernode

ufw allow 10250/tcp <-Allow Kubelet

ufw allow 4789/udp <- Allow Calico VXLAN overlay traffic

ufw allow in on eth0 to any port 4789 proto udp

