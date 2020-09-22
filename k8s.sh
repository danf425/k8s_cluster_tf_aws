/bin/...

#establish k8s repo
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

#install k8s
sudo yum install -y kubelet kubeadm kubectl
systemctl enable kubelet
systemctl start kubelet

#setup a hostname. change 'i' to something like ip
sudo hostnamectl set-hostname node-i
#modify entry or DNS to resolve to hostname
sudo vi /etc/hosts
#with an entry like:
THEIP master.theygiveflowers.com master-node
THEIP node1.theygiveflowers.com node1 worker-node

#ensure that echo(ping) is enabled within the security group inbound rules
#Type: Custom ICMP rule
#Protocol: Echo Request
#Port: N/A
#source: Anywhere

#install and activate firwalld
sudo yum install firewalld
sudo systemctl enable firewalld
sudo reboot

#on master node
sudo firewall-cmd --permanent --add-port=6443/tcp
sudo firewall-cmd --permanent --add-port=2379-2380/tcp
sudo firewall-cmd --permanent --add-port=10250/tcp
sudo firewall-cmd --permanent --add-port=10251/tcp
sudo firewall-cmd --permanent --add-port=10252/tcp
sudo firewall-cmd --permanent --add-port=10255/tcp
sudo firewall-cmd --reload
modprobe br_netfilter
# echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables


#on worker nodes
sudo firewall-cmd --permanent --add-port=10251/tcp
sudo firewall-cmd --permanent --add-port=10255/tcp
firewall-cmd --reload

#update iptables:
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

#disable selinux
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

#disable SWAP
sudo sed -i '/swap/d' /etc/fstab
sudo swapoff -a


#t2.medium needed (2 cpus needed)
#make sure inbound rules  are allowed for TCP 6443 withing AWS security groups