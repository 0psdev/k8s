# How to install K8S
Basic Kubernetes (K8S) installation in a small environment that’s practical enough to be used in real scenarios.

# Stack
- OS: Ubuntu
- Container Runtime: CRI‑O
- Cluster Tooling: kubeadm
- CNI Plugin: Calico

# Propose
1. For basic learning and hands‑on practice.
2. For proof of concept (POC) in office environments.
3. For small workloads (on‑premise setups may require a load balancer when exposing services).

# Step
1. Prepare your host before install software -> https://github.com/0psdev/k8s/blob/main/Host/prepare.sh
2. Install container runtime (using cri-o) -> https://github.com/0psdev/k8s/blob/main/CRI-O/crio.sh
3. Install K8S (using kubeadm) -> https://github.com/0psdev/k8s/blob/main/K8S/k8s.md
4. Install CNI plugin (calico)
5. Install Metrics Server (kubeclt top)
