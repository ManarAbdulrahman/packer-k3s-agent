#!/bin/bash
sudo apt update -y && sleep 30 && sudo apt install -y curl vim jq git docker.io
sudo apt install -y build-essential
sudo apt install -y make
sudo usermod -aG docker ubuntu
export K3S_HOST=controlplane.phi.com
export K3S_TOKEN=$(cat /home/ubuntu/token)
export K3S_URL=https://$K3S_HOST:6443
curl -sfL https://get.k3s.io | sh -

