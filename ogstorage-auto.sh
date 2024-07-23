#!/bin/bash

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 1
# packages

sudo apt-get install clang cmake build-essential git -y

# install go
cd $HOME && sudo rm -rf /usr/local/go
wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

# install rustup
curl --proto '=https' --tlsv1.2 

# disable service
sudo systemctl stop zgs.service
sudo systemctl disable zgs.service
sudo rm /etc/systemd/system/zgs.service

# git clone  & build
git clone https://github.com/0glabs/0g-storage-node.git

# IF YOU INSTALLED V0.3.3, START FROM HERE

cd $HOME/0g-storage-node
git stash
git tag -d v0.3.3
git fetch --all --tags
git checkout v0.3.4
git submodule update --init
sudo apt install cargo
cargo build --release

# setup variable
sudo wget -O $HOME/0G_STORAGE_CONFIG.sh https://0g.service.nodebrand.xyz/0G/0G_STORAGE_CONFIG.sh
chmod +x $HOME/0G_STORAGE_CONFIG.sh
$HOME/0G_STORAGE_CONFIG.sh
source ~/.bash_profile

# Create Service File
sudo tee /etc/systemd/system/zgs.service > /dev/null <<EOF
[Unit]
Description=ZGS Node
After=network.target

[Service]
User=root
WorkingDirectory=$ZGS_HOME/run
ExecStart=$ZGS_HOME/target/release/zgs_node --config $ZGS_HOME/run/config.toml
Restart=on-failure
RestartSec=10
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF

# service execution
sudo systemctl daemon-reload && \
sudo systemctl enable zgs && \
sudo systemctl start zgs

#check logs
tail -f $ZGS_HOME/run/log/zgs.log.$(TZ=UTC date +%Y-%m-%d)
