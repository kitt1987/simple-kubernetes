#Simple Kubernetes

This project aims to install Kubernetes without any dependencies on private or banned resources.

##Dependency
**Ansible 2.6**

Simple Kubernetes is an Ansible playbook. You need to install Ansible 2.6 on your workstation.

**Github or The Server Binaries Kubernetes released**
Simple Kubernetes will load Kubernetes images and programs from the server-side binaries released on Github. You can either download it manually and saved into directory 'kube-release' or let the program do it for you.

**Docker on hosts**

##Inventory
You can copy and paster a new inventory from inventory/sample. The most important part is to specify master and nodes. You may also change some variables to make the program compatible with your environment, which are,

**kube_release_version**
The version of Kubernetes you would like to install. The program can't detect the latest Kubernetes release on Github. You have to specify it.

**ansible_python_interpreter**
If your hosts are CentOS or RHEL, you should set this variable to `/usr/bin/python`.

**pod_cidr,service_cidr,cluster_dns, and cluster_api_server**
It is no need to change these variables unless both CIDRs overlap your host network. Once `service_cidr` changed, assure that `cluster_dns` and `cluster_api_server` are in the subnet `service_cidr` defined.

##Playbook
As ansible required, the workstation needs to login to each host via SSH without any prompts. Before running any playbooks, you have to run `ssh-copy-id root@hostname` with each host.

You can run the following ansible to install a cluster.
`ansible-playbook -i {{inventory}} deploy-cluster.yml`

Or, clean an installation.
`ansible-playbook -i {{inventory}} clean-cluster.yml`

##Things haven't done
- [ ] Install compatible Docker automatically
- [ ] Figure out the latest Kubernetes release from Github
- [ ] Verify existed Kubernetes release package