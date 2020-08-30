#!/bin/bash
sudo apt update -y && sudo apt install -y curl vim git
curl -L get.docker.com | sh
sudo apt install  -y netcat-traditional
sudo apt install -y make
sudo usermod -aG docker ubuntu
sudo cat <<EOF >> /home/ubuntu/serverinfo.sh
#!/bin/bash
export K3S_HOST=controlplane.phi.com
export K3S_TOKEN="\$(nc $K3S_HOST 12345)"
export K3S_URL=https://$K3S_HOST:6443
EOF
sudo chmod a+x /home/ubuntu/serverinfo.sh
sudo cat <<EOF >> /home/ubuntu/get_token.service
[Unit]
Description=Example systemd service.

[Service]
Type=simple
Restart=always
RestartSec=5
ExecStart=/home/ubuntu/serverinfo.sh

[Install]
WantedBy=multi-user.target
EOF
sudo mv /home/ubuntu/get_token.service /lib/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable get_token
sudo systemctl start get_token
curl -sfL https://get.k3s.io | sh -

