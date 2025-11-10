# Update helm repo
helm repo add projectcalico https://docs.tigera.io/calico/charts
helm repo update

# List version on 
helm repohelm search repo projectcalico/tigera-operator --versions

# Create namespace
kubectl create namespace tigera-operator

# Install calico via helm
helm install calico projectcalico/tigera-operator --version 3.31.0 -f values.yaml --namespace tigera-operator