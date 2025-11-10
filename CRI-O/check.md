# Check result
sudo systemctl status crio

sudo ss -ltn | grep /var/run/crio/crio.sock

crictl info