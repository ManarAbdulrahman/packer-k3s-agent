#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim git
curl -L get.docker.com | sh
sudo apt install  -y netcat-traditional
sudo apt install -y make
sudo usermod -aG docker ubuntu
sudo cat <<EOF >> /home/ubuntu/serverinfo.sh
#!/bin/bash
export K3S_HOST=controlplane.phi.com
export K3S_TOKEN="\$(nc.traditional $K3S_HOST 12345)"
export K3S_URL=https://$K3S_HOST:6443
echo 'export K3S_HOST=controlplane.phi.com' >> ~/.bashrc
echo 'export K3S_TOKEN="\$(nc.traditional $K3S_HOST 12345)"' >> ~/.bashrc
echo 'export K3S_URL=https://$K3S_HOST:6443' >> ~/.bashrc
sudo systemct stop k3s
sudo k3s agent --server ${K3S_URL} --token ${K3S_TOKEN}
EOF
sudo chmod a+x /home/ubuntu/serverinfo.sh
sudo cat <<EOF >> /home/ubuntu/get_token.service
[Unit]
Description=Example systemd service.

[Service]
Type=simple
ExecStart=/home/ubuntu/serverinfo.sh

[Install]
WantedBy=multi-user.target
EOF
sudo mv /home/ubuntu/get_token.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable get_token
sudo systemctl start get_token
curl -sfL https://get.k3s.io | sh -

