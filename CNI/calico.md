# Update helm repo
helm repo add projectcalico https://docs.tigera.io/calico/charts

helm repo update

# List version on 
helm search repo projectcalico/tigera-operator --versions

# Create namespace
kubectl create namespace tigera-operator

# Install calico via helm
helm install calico projectcalico/tigera-operator --version 3.31.0 -f values.yaml --namespace tigera-operator

# Additional for manage Calico via calicoctl
curl -O -L https://github.com/projectcalico/calico/releases/download/v3.30.4/calicoctl-linux-amd64

chmod +x calicoctl-linux-amd64

sudo mv calicoctl-linux-amd64 /usr/local/bin/calicoctl

export DATASTORE_TYPE=kubernetes

