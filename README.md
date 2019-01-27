# Simple Kubernetes

This project aims to install Kubernetes without any dependencies on private or banned resources.

## Playbook
Before running any playbooks, you should run `ssh-copy-id root@hostname` with each host. 

You can run the following ansible to install a cluster.

`ansible-playbook -i {{inventory}} deploy-cluster.yml`

Or, clean an installation.

`ansible-playbook -i {{inventory}} clean-cluster.yml`

## Dependency
**Ansible 2.7**

Simple Kubernetes is an Ansible playbook. You need to install Ansible 2.7 on your workstation.

**GitHub, Docker Hub and Quay.io**

The program also need to download some binaries and images. Some of them could be quite slow. If you are in **MainLand China**, I strongly recommand you download binaries manually, and specify alternatives you downloaded in the inventory file. 

* Kubernetes release from https://github.com/kubernetes/kubernetes and https://dl.k8s.io
* CNI plugins from https://github.com/containernetworking/plugins
* Docker from docker.com
* quay.io/coreos/etcd:v3.2.18 from https://quay.io/
* coredns/coredns from Docker Hub and its configuration from GitHub

## Inventory
You can copy and paste a new inventory from inventory/sample. The critical part is to specify master and nodes. You may also change some variables to make the program compatible with your environment, which are,

**kube_release_version**

You can also set the version of Kubernetes you would like to install. Or, the program will choose the latest release.

**pod_cidr,service_cidr,cluster_dns, and cluster_api_server**

It is no need to change these variables unless both CIDRs overlap your host network. Once `service_cidr` changed, assure that `cluster_dns` and `cluster_api_server` are in the subnet `service_cidr` defined.

## Things haven't done
- [x] Install compatible Docker automatically
- [x] Modify /etc/hosts to make hosts know each other if no DNS
- [x] Figure out the latest Kubernetes release from Github
- [ ] Install HA clusters
- [x] Support CNI