#!/bin/bash
set -xe

exec > >(tee /var/log/openvpn-userdata.log) 2>&1

echo "User-data started at $(date)"

# Wait for network
until curl -s https://ifconfig.me >/dev/null; do
  echo "Waiting for internet..."
  sleep 5
done

# Download installer
curl -fsSL https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh -o /root/openvpn-install.sh
chmod +x /root/openvpn-install.sh

# Non-interactive install
export AUTO_INSTALL=y
export APPROVE_INSTALL=y
export ENDPOINT=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
export DNS=1
export PORT_CHOICE=1
export PROTOCOL_CHOICE=1
export CLIENT=client

./openvpn-install.sh install

echo "User-data finished at $(date)"