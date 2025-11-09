#!/usr/bin/env bash

#Define versions
KUBERNETES_VERSION=v1.33
CRIO_VERSION=v1.33
KEYRING_DIR=/etc/apt/keyrings

mkdir -p "$KEYRING_DIR"

apt-get update
apt-get install -y software-properties-common curl gnupg ca-certificates

echo "Adding Kubernetes repo and key..."
curl -fsSL "https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key" \
  | gpg --dearmor -o "$KEYRING_DIR/kubernetes-apt-keyring.gpg"
echo "deb [signed-by=$KEYRING_DIR/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" \
  > /etc/apt/sources.list.d/kubernetes.list

echo "Adding CRI-O repo and key..."
curl -fsSL "https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key" \
  | gpg --dearmor -o "$KEYRING_DIR/cri-o-apt-keyring.gpg"
echo "deb [signed-by=$KEYRING_DIR/cri-o-apt-keyring.gpg] https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/ /" \
  > /etc/apt/sources.list.d/cri-o.list

apt-get update
apt-get install -y cri-o

systemctl daemon-reload
systemctl enable --now crio.service

echo "CRI-O installed and started."
//