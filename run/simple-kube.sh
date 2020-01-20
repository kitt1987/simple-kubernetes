#!/usr/bin/env bash

# Mount tmpfs for SSH ControlPath to work around SSH failures on overlay.
# See https://github.com/moby/moby/issues/12080

mkdir -p lib/on-prem-cache

docker run --name simple-kube --net=host -ti --rm \
  -e http_proxy="${http_proxy}" -e https_proxy="${https_proxy}" -e no_proxy="${no_proxy}" \
  --mount type=tmpfs,destination=/root/.ansible/cps \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/lib/releases:/simple-kube/lib/releases \
  -v $(pwd)/inventory:/simple-kube/lib/inventory \
  -v $(pwd)/lib/on-prem-cache:/simple-kube/lib/on-prem-cache \
  kitt0hsu/simple-kube
