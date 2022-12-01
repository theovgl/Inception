echo "============= APT UPDATE ============="

apt-get update
apt-get install -y \
	ca-certificates \
	curl \
	gnupg \
	lsb-release \
	squid \
	vim \
	make

echo "============= ADD TVOGEL USER ============="
#if id -u "tvogel" &>/dev/null; then
	useradd -m -s /bin/bash -U tvogel
	cp -pr /home/vagrant/.ssh /home/tvogel
	chown -R tvogel:tvogel /home/tvogel
	echo "%tvogel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/tvogel
#else
#	echo "user tvogel already exists"
#fi

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
sudo usermod -aG docker tvogel
newgrp docker

echo "============= EDIT /ETC/HOSTS ============="
sed -i "s/localhost/tvogel.42.fr adminer.tvogel.42.fr/g" /etc/hosts
cat /etc/hosts

echo "============= RUN SQUID PROXY ============="
# Run squid proxy
rm /etc/squid/squid.conf
echo "http_port 3128

# Example rule allowing access from your local networks.
# Adapt to list your (internal) IP networks from where browsing
# should be allowed
acl all src 0.0.0.0/0
acl localnet src 0.0.0.1-0.255.255.255  # RFC 1122 "this" network (LAN)
acl localnet src 10.0.0.0/8             # RFC 1918 local private network (LAN)
acl localnet src 100.64.0.0/10          # RFC 6598 shared address space (CGN)
acl localnet src 169.254.0.0/16         # RFC 3927 link-local (directly plugged) machines
acl localnet src 172.16.0.0/12          # RFC 1918 local private network (LAN)
acl localnet src 192.168.0.0/16         # RFC 1918 local private network (LAN)
acl localnet src fc00::/7               # RFC 4193 local private network range
acl localnet src fe80::/10              # RFC 4291 link-local (directly plugged) machines

acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http

http_access allow localhost manager
http_access deny manager

#
# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
#
http_access allow all
http_access allow localnet
http_access allow localhost

coredump_dir /squid/var/cache/squid

refresh_pattern ^ftp:           1440    20%     10080
refresh_pattern ^gopher:        1440    0%      1440
refresh_pattern -i (/cgi-bin/|\?) 0     0%      0
refresh_pattern .               0       20%     4320" > /etc/squid/squid.conf
sudo service squid restart

# Upgrade all packages
echo "============= APT UPGRADE ============="
apt upgrade -y
