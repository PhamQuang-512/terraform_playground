#!/bin/bash


# sudo apt-get install -y unzip libtool libltdl-dev

# curl -s -L -o ~/vault.zip ${var.vault_url}
# sudo unzip ~/vault.zip
# sudo install -c -m 0755 vault /usr/bin

# sudo mkdir -p /test/vault

# sudo echo -e '[Unit]\nDescription="HashiCorp Vault - A tool for managing secrets"\nDocumentation=https://www.vaultproject.io/docs/\nRequires=network-online.target\nAfter=network-online.target\n\n[Service]\nExecStart=/usr/bin/vault server -config=/test/vault/config.hcl\nExecReload=/bin/kill -HUP $MAINPID\nKillMode=process\nKillSignal=SIGINT\nRestart=on-failure\nRestartSec=5\n\n[Install]\nWantedBy=multi-user.target\n' > /lib/systemd/system/vault.service

# sudo echo -e 'storage "file" {\n  path = "/opt/vault"\n}\n\nlistener "tcp" {\n  address     = "127.0.0.1:8200"\n  tls_disable = 1\n}\n\nseal "gcpckms" {\n  project     = "${var.gcloud-project}"\n  region      = "${var.keyring_location}"\n  key_ring    = "${var.key_ring}"\n  crypto_key  = "${var.crypto_key}"\n}\n\ndisable_mlock = true\n' > /test/vault/config.hcl

# sudo chmod 0664 /lib/systemd/system/vault.service

# sudo echo -e 'alias v="vault"\nalias vault="vault"\nexport VAULT_ADDR="http://127.0.0.1:8200"\n' > /etc/profile.d/vault.sh

# source /etc/profile.d/vault.sh

# sudo systemctl enable vault
# sudo systemctl start vault

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install vault