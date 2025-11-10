#!/usr/bin/env bash

# Set timezone
sudo timedatectl set-timezone Asia/Bangkok

#Install required packages
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

#Disable swap
swapoff -a
sed -i -E '/\sswap\s/s/^/#/' /etc/fstab || true

#Load module
modprobe overlay || true
modprobe br_netfilter || true

#Prepare networking
cat > /etc/sysctl.d/k8s.conf <<'EOF'
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

#Apply sysctl
sysctl --system

echo "Prepared host successfully."
//