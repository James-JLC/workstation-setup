sudo su root
cat <<EOF >/etc/apt/sources.list.d/docker-k8s.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable
EOF

apt-get update && apt-get install -y docker-ce kubelet kubeadm kubectl

swapoff -a

for i in `kubeadm config images list`; do
    imageName=${i#k8s.gcr.io/}
    echo "docker pull hub-mirror.c.163.com/kubesphere/$imageName"
    docker pull hub-mirror.c.163.com/kubesphere/$imageName
    docker tag hub-mirror.c.163.com/kubesphere/$imageName k8s.gcr.io/$imageName
    docker rmi hub-mirror.c.163.com/kubesphere/$imageName
done;

for i in `kubeadm config images list`; do
　　imageName=${i#k8s.gcr.io/}
　　docker pull registry.aliyuncs.com/google_containers/$imageName
　　docker tag registry.aliyuncs.com/google_containers/$imageName k8s.gcr.io/$imageName
　　docker rmi registry.aliyuncs.com/google_containers/$imageName
done;
