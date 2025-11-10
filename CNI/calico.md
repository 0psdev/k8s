# Install calico via helm
helm repo add projectcalico https://docs.tigera.io/calico/charts
helm repo update

kubectl create namespace tigera-operator

helm install calico projectcalico/tigera-operator -f values.yaml --namespace tigera-operator