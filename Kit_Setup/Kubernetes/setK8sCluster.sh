#/bin/bash
## https://kubernetes.io/ja/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/

## Serverlist
Serverlist=(`cat /etc/Serverlist.conf|xargs`)

# kubeadm init
kubeadm init --pod-network-cidr=10.244.0.0/16 2>&1 | tee /root/setkubeadm.log

## kubectl config
mkdir -p $HOME/.kube
\cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config
for node in "${Serverlist[@]}"
do
    ssh $node 'mkdir -p $HOME/.kube'
    scp /root/.kube/config $node:/root/.kube/config
done

## Make flannel Network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


## kubeadm join
echo '#/bin/bash' > ./kubeadmJoin.sh
tail -n 2 setkubeadm.log >> ./kubeadmJoin.sh
chmod 755 ./kubeadmJoin.sh
for node in "${Serverlist[@]}"
do
    scp ./kubeadmJoin.sh $node:/root/kubeadmJoin.sh
    ssh $node '/root/kubeadmJoin.sh'
done

kubectl get nodes
kubectl get pods --all-namespaces

## (Option)Service-node-port-range Change
cp /etc/kubernetes/manifests/kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.org.yaml
sed -i -e '15i \ \ \  - --service-node-port-range=1-32767' /etc/kubernetes/manifests/kube-apiserver.yaml