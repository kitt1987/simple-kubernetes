# simple-kube

`simple-kube` aims to install Kubernetes not depend on any private or banned resources.

## Install your cluster

### Run simple-kube in container

```
bash <(curl -sL https://raw.githubusercontent.com/kitt1987/simple-kubernetes/master/run/simple-kube.sh)
```

## Run the playbook

We've generated an **SSH key pair** in the container. You can install it on hosts outlined in the inventory. Or, generate your key pairs for security. 

To install a cluster,

```
ansible-playbook -i inventory/sample deploy-cluster.yml
```

To clean an installation,

```
ansible-playbook -i inventory/sample clean-cluster.yml
```

Once failures arose before installation get done, clean the cluster would restore stale hosts.

## Add new nodes

To add new nodes,

```
ansible-playbook -i inventory/sample add-node.yml
```

## Advanced Features

### Build the ON-PREM version of simple-kube 

In on-premise environments, `simple-kube` can't download images or configurations from the Internet. It provides an alternative way to build a new simple-kube image which doesn't need to fetch Internet resources. 

1. Run simple-kube by `run/simple-kube.sh` or make sure that `/var/run/docker.sock` is mounted to the container,
2. Assure that the simple-kube container could access the Internet,
3. Install a cluster,
4. Set `kube_release_version` and disable `verify_kube_release` in the inventory,
4. Commit the container to create a new simple-kube image.

```
docker commit -m "kubernetes version v1.12.9" -p simple-kube kitt0hsu/simple-kube:v1.12.9
```

### Change Pod/Service CIDR

Before running the playbook, make sure hostnames, their IP addresses and the K8s version in the inventory exactly match your cluster.

```
ansible-playbook -i inventory/sample apply-cidrs.yml
```

After the playbook done successfully, your legacy cluster configuration and Etcd data were copied to directory **/root/.simple-kube**. You need to copy the SA certificate back to **/etc/kubernetes/pki** and restore the manifest of kube-apiserver to use the original SA certificate. Meanwhile, all services have to be rebuilt. Moreover, you have to update the configuration of CNI plugin manually.

## Dependencies

### From the Internet

`simple-kube` will download binaries and images. Some of them could be quite slow. In **MainLand China**, I strongly recommend you download binaries below manually, and specify them in the inventory. 

* Kubernetes releases from https://github.com/kubernetes/kubernetes and https://dl.k8s.io
* CNI plugins releases from https://github.com/containernetworking/plugins
* Docker from docker.com
* Image `quay.io/coreos/etcd:v3.2.18` from https://quay.io/
* Image `coredns/coredns` from Docker Hub and its configuration from GitHub

### From package repositories of distros

`simple-kube`  also installs some packages on hosts while installing clusters. Most of them could be found in the official package repository of each distro. They are,

* rsync
* jq

## Feature List
- [x] Install compatible Docker automatically
- [x] Modify /etc/hosts to make hosts know each other if no DNS
- [x] Fetch the latest Kubernetes release from Github
- [x] Support CNI
- [x] Install HA cluster
- [x] Save all the downloaded files for following installation
- [x] Support HTTP_PROXY environment variables in the playbook and container
- [ ] Install main stream CNI plugin
- [ ] Divergent manifests for different releases
- [ ] Parse coredns image from configuration