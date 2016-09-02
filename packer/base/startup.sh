export PRIVATE_IP=$(curl http://169.254.169.254/metadata/v1/interfaces/private/0/ipv4/address)
sed -i -e "s/{{PRIVATE_IP}}/$PRIVATE_IP/g" /etc/prometheus.yml