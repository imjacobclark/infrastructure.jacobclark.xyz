# Create swap file
fallocate -l 4G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
echo "vm.swappiness=10" >> /etc/sysctl.conf

# Install dependencies
apt-get update
apt-get install sbcl git -y

# Clone HTTP server
git clone https://github.com/imjacobclark/cl-servers.git ~/cl-servers

# Enable startup provisioner
systemctl daemon-reload
systemctl enable http-server.service
systemctl start http-server.service