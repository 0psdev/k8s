# Install Cilium via helm
helm repo add cilium https://helm.cilium.io/

helm repo update

helm install cilium cilium/cilium  \\

  --version 1.18.4  \\

  --namespace kube-system  \\

  --set ipam.mode=cluster-pool \\

  --set ipam.operator.clusterPoolIPv4PodCIDRList="{10.10.1.0/24}" \\

  --set ipam.operator.clusterPoolIPv4MaskSize=26 \\

  --set kubeProxyReplacement=true \\

  --set k8sServiceHost=cl1ct1.home.local \\

  --set k8sServicePort=6443 \\

  --set k8sServiceCIDR=172.31.1.0/24

# Install Cilium (eBPF+vxlan) via helm
helm install cilium cilium/cilium --version 1.18.4 \\

  --namespace kube-system \\

  --set ipam.mode=cluster-pool \\

  --set ipam.operator.clusterPoolIPv4PodCIDRList="{10.10.3.0/24}" \\

  --set ipam.operator.clusterPoolIPv4MaskSize=26 \\

  --set kubeProxyReplacement=true \\

  --set routingMode=tunnel \\

  --set tunnelProtocol=vxlan \\

  --set nodePort.enabled=true \\

  --set enableIPv4Masquerade=true \\

  --set bpf.masquerade=true \\

  --set hostReachableServices.enabled=true \\

  --set cluster.id=1 \\
  
  --set cluster.name=cluster-a

# Install cilium CLI
# Determine the latest stable version and target architecture
CILIUM_CLI_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/cilium-cli/main/stable.txt)
CLI_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then
  CLI_ARCH=arm64
fi


# Download the tarball and its SHA-256 checksum
curl -L --fail --remote-name-all \
  https://github.com/cilium/cilium-cli/releases/download/${CILIUM_CLI_VERSION}/cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}


# Verify the checksum before extraction
sha256sum --check cilium-linux-${CLI_ARCH}.tar.gz.sha256sum


# Extract and install the binary
sudo tar xzvf cilium-linux-${CLI_ARCH}.tar.gz -C /usr/local/bin


# Remove downloaded files
rm cilium-linux-${CLI_ARCH}.tar.gz{,.sha256sum}

cilium status

# Option for hubble install via helm
helm upgrade cilium cilium/cilium \\

   --namespace kube-system \\

   --reuse-values \\

   --set hubble.relay.enabled=true \\
   
   --set hubble.ui.enabled=true


# Option for hubble CLI
HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
HUBBLE_ARCH=amd64
if [ "$(uname -m)" = "aarch64" ]; then HUBBLE_ARCH=arm64; fi
curl -L --fail --remote-name-all https://github.com/cilium/hubble/releases/download/${HUBBLE_VERSION}/hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}
sha256sum --check hubble-linux-${HUBBLE_ARCH}.tar.gz.sha256sum
sudo tar xzvfC hubble-linux-${HUBBLE_ARCH}.tar.gz /usr/local/bin
rm hubble-linux-${HUBBLE_ARCH}.tar.gz{,.sha256sum}

cilium hubble port-forward&

hubble observe

# Enable eBPF

helm upgrade cilium cilium/cilium --version 1.18.4 \\

  --namespace kube-system \\

  --set ipam.mode=cluster-pool \\

  --set ipam.operator.clusterPoolIPv4PodCIDRList="{10.10.1.0/24}" \\

  --set ipam.operator.clusterPoolIPv4MaskSize=26 \\

  --set kubeProxyReplacement=true \\

  --set routingMode=tunnel \\

  --set tunnelProtocol=vxlan \\

  --set nodePort.enabled=true \\

  --set enableIPv4Masquerade=true \\

  --set bpf.masquerade=true \\

  --set hostReachableServices.enabled=true \\

  --set cluster.id=1 \\

  --set cluster.name=cluster-a

  # Option enable mesh

  need to edit context default name and add kubeconfig -> kubectl config set-context cl1 --cluster=cl1 --user=kubernetes-admin
  
  kubectl create clusterrolebinding admin-secrets --clusterrole=cluster-admin --user=kubernetes-admin
