curl http://169.254.169.254/metadata/v1/interfaces/private/0/ipv4/address > /etc/privateip.txt

ufw allow from $(cat /etc/privateip.txt)
ufw reload

# Start prometheus scrapers on correct private IP
sed -i -e "s/{{PRIVATE_IP}}/$(cat /etc/privateip.txt)/g" /etc/prometheus.yml
docker restart prometheus
exit 0