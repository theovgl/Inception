echo "============= APT UPDATE ============="

apt-get update
apt-get install -y \
	ca-certificates \
	curl \
	gnupg \
	lsb-release

# Add docker repo to apt
echo "============= ADD DOCKER REPO TO APT ============="
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg


echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update

# Install Docker
echo "============= INSTALL DOCKER PACKAGES ============="
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Create docker group and add "vagrant" user in it
sudo groupadd docker
sudo usermod -aG docker vagrant
newgrp docker

# Upgrade all packages
echo "============= APT UPGRADE ============="
apt upgrade -y
