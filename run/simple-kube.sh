#!/usr/bin/env bash

# Mount tmpfs for SSH ControlPath to work around SSH failures on overlay.
# See https://github.com/moby/moby/issues/12080

mkdir -p releases inventory on-prem-cache

docker run --name simple-kube --net=host -ti --rm \
  -e http_proxy="${http_proxy}" -e https_proxy="${https_proxy}" -e no_proxy="${no_proxy}" \
  --mount type=tmpfs,destination=/root/.ansible/cps \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/releases:/simple-kube/releases \
  -v $(pwd)/inventory:/simple-kube/inventory \
  -v $(pwd)/on-prem-cache:/simple-kube/on-prem-cache \
  kitt0hsu/simple-kube:95fbda4019a49ecc5f458e18d507ede7f5e395f7-20200119164938
