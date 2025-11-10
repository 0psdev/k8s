#!/usr/bin/env bash
# ...existing code...

set -euo pipefail

#Define versions
KUBERNETES_VERSION=v1.33 #<-- version base on customer need
CRIO_VERSION=v1.33 #<-- version relate to kubernetes version
KEYRING_DIR=/etc/apt/keyrings

sudo mkdir -p "$KEYRING_DIR"

sudo apt-get update
sudo apt-get install -y software-properties-common curl gnupg ca-certificates

echo "Adding Kubernetes repo and key..."
curl -fsSL "https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key" \
  | sudo gpg --dearmor -o "$KEYRING_DIR/kubernetes-apt-keyring.gpg"
echo "deb [signed-by=$KEYRING_DIR/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null

echo "Adding CRI-O repo and key..."
curl -fsSL "https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key" \
  | sudo gpg --dearmor -o "$KEYRING_DIR/cri-o-apt-keyring.gpg"
echo "deb [signed-by=$KEYRING_DIR/cri-o-apt-keyring.gpg] https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/ /" \
  | sudo tee /etc/apt/sources.list.d/cri-o.list > /dev/null

sudo apt-get update
sudo apt-get install -y cri-o

# ensure CRI-O log directories exist and are writable by the daemon
sudo mkdir -p /var/log/crio/pods
sudo chown -R root:root /var/log/crio
sudo chmod 0755 /var/log/crio

sudo systemctl daemon-reload
sudo systemctl enable --now crio.service

sudo apt-mark hold cri-o #Hold cri-o version

echo "CRI-O installed and started."
// ...existing code...