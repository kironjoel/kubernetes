####################################################################################
# Run this script as root
####################################################################################

# Get the Docker gpg key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository:
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Get the Kubernetes gpg key:
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Add the Kubernetes repository:
cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Update your packages:
apt-get update

# Install Docker, kubelet, kubeadm, and kubectl:
apt-get install -y docker-ce kubelet=1.18.5-00 kubeadm=1.18.5-00 kubectl=1.18.5-00

# Hold them at the current version:
apt-mark hold docker-ce kubelet kubeadm kubectl

# Add the iptables rule to sysctl.conf:
echo "net.bridge.bridge-nf-call-iptables=1" | tee -a /etc/sysctl.conf

# Enable iptables immediately:
sysctl -p

# Setup autocomplete and aliases
source <(kubectl completion bash) # setup autocomplete in bash into the current shell, bash-completion package should be installed first.
echo "source <(kubectl completion bash)" >> ~/.bashrc # add autocomplete permanently to your bash shell.
echo "alias k=kubectl" >> ~/.bashrc
echo "complete -F __start_kubectl k" >> ~/.bashrc