#!/bin/bash
sudo apt update -y && sleep 30 && sudo apt install -y curl vim git docker.io
sudo apt install  -y netcat-traditional
sudo apt install -y make
sudo groupadd docker
sudo usermod -aG docker ubuntu
export K3S_HOST=controlplane.phi.com
export K3S_TOKEN=$(nc.traditional $K3S_HOST 12345)
export K3S_URL=https://$K3S_HOST:6443
curl -sfL https://get.k3s.io | sh -

