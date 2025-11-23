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
4. Install CNI plugin -> [calico](https://github.com/0psdev/k8s/tree/main/CNI/calico)
                      -> [cilium](https://github.com/0psdev/k8s/tree/main/CNI/cilium)
5. Install Metrics Server (kubeclt top)

# ⭐ Remark
1. When designing Kubernetes installation, network addressing is critical. IP addresses must not overlap. If you plan to deploy multiple clusters, ensure each cluster uses a distinct network address range to avoid conflicts and maintain stable connectivity.
2. By theory, you can modify POD-CIDR and SERVICE-CIDR in the YAML configuration. However, in practice this is very difficult. You cannot simply change the CIDR to a different subnet; the only feasible option is to extend the existing subnet to support a larger Pod network.
