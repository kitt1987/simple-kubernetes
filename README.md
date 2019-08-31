# simple-kube

`simple-kube` aims to install Kubernetes not depend on any private or banned resources.

## Install your cluster

### Run simple-kube in container

To run the playbook without any preparation,

```
bash <(curl -sL https://raw.githubusercontent.com/kitt1987/simple-kubernetes/master/run/simple-kube.sh)
```

It is optional to mount the Docker socket to the container.  See remaining sections.

## Run the playbook

We've generated an SSH key pair in the container. You can install it on hosts outlined in the inventory. Or, generate your key pairs for security. 

To install a cluster,

```
ansible-playbook -i inventory/sample deploy-cluster.yml
```

To clean an installation,

```
ansible-playbook -i inventory/sample clean-cluster.yml
```

Once failures arose before installation get done, clean the cluster would restore stale hosts.

### Save resources downloaded for completely on-premise hosts

In on-premise environments, `simple-kube` can't download images or configurations from the Internet. It provides an alternative way to get them. 

Once you mount the local Docker socket `/var/run/docker.sock` to the `simple-kube` container, it will keep all the downloaded images and configurations in the container after the first complete installation. Then, you can commit the container and use the new image on-prem.

```
docker commit -m "kubernetes version v1.12.9" -p simple-kube kitt0hsu/simple-kube:v1.12.9
```

## Advanced Features

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
- [ ] Support bootstrap token
- [ ] Install main stream CNI plugin
- [ ] Divergent manifests for different releases
- [ ] Parse coredns image from configuration