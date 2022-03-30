#! /bin/bash

sudo apt update -y
sudo apt upgrade -y
snap install google-cloud-sdk --classic -y
sudo apt install unzip -y
curl -O https://releases.hashicorp.com/terraform/1.0.4/terraform_1.0.4_linux_amd64.zip
unzip terraform_1.0.4_linux_amd64.zip
sudo mv terraform /usr/local/bin/
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256) kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
gcloud container clusters get-credentials devops-telkomsel-3 --zone australia-southeast2-a --project purwadhika-devops-kelas1
sudo cat ~/.kube/config
