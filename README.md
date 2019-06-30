# simple-kube

`simple-kube` aims to install Kubernetes not depend on any private or banned resources.

## Install your cluster

### Run simple-kube in container

To run the playbook without any preparation,

`docker run --name simple-kube -ti --rm -v /var/run/docker.sock:/var/run/docker.sock kitt0hsu/simple-kube`

It is optional to mount the Docker socket to the container.  See remaining sections.

## Run the playbook

We've generated an SSH key pair in the container. You can install it on hosts outlined in the inventory. 

To install a cluster,

`ansible-playbook -i sample/inventory deploy-cluster.yml`

To clean an installation,

`ansible-playbook -i sample/inventory clean-cluster.yml`

Once failures arose before installation get done, clean the cluster would restore stale hosts.

### Resources cache for completely on-premium hosts

In on-premise environments, `simple-kube` can't download images or configurations from the Internet. `simple-kube` provides a simple way to collect and cache these resources. 

Once you mount the local Docker socket `/var/run/docker.sock` to the `simple-kube` container, it will cache all the downloaded images and configurations in the container after the first complete installation. Then, you can commit the container and use the new image on-prem.

`docker commit -m "kubernetes version v1.12.9" -p simple-kube kitt0hsu/simple-kube:v1.12.9`

## Dependencies

### From the Internet

`simple-kube` will download some binaries and images. Some of them could be quite slow. In **MainLand China**, I strongly recommend you download the binaries below manually, and specify the substitutes in the inventory. 

* Kubernetes releases from https://github.com/kubernetes/kubernetes and https://dl.k8s.io
* CNI plugins releases from https://github.com/containernetworking/plugins
* Docker from docker.com
* Image `quay.io/coreos/etcd:v3.2.18` from https://quay.io/
* Image `coredns/coredns` from Docker Hub and its configuration from GitHub

### From package repositories of distros

`simple-kube`  also installs some packages on hosts while installing clusters. Most of them could be found in the official package repository of each distro. They are,

* rsync
* jq

## Things haven't done
- [x] Install compatible Docker automatically
- [x] Modify /etc/hosts to make hosts know each other if no DNS
- [x] Figure out the latest Kubernetes release from Github
- [x] Support CNI
- [x] Install HA clusters
- [x] Save all the downloaded files for the next installation
- [ ] Support HTTP_PROXY environment variables in the playbook and container
- [ ] Support bootstrap token
- [ ] Install main stream CNI plugin
- [ ] Divergent manifests for different releases