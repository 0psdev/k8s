helm repo add cilium https://helm.cilium.io/
helm repo update

helm install cilium cilium/cilium --version 1.18.4 \
  --namespace kube-system \
  --set ipam.mode=cluster-pool \
  --set ipam.operator.clusterPoolIPv4PodCIDRList="{10.10.1.0/24}" \
  --set ipam.operator.clusterPoolIPv4MaskSize=26 \
  --set kubeProxyReplacement=true \
  --set k8sServiceHost=cl1ct1.home.local \ <- **** api endpoint
  --set k8sServicePort=6443 \
  --set k8sServiceCIDR=172.31.1.0/24