#!/usr/bin/env bash

# Mount tmpfs for SSH ControlPath to work around SSH failures on overlay.
# See https://github.com/moby/moby/issues/12080

mkdir -p releases inventory on-prem-cache

docker run --name simple-kube --net=host -ti --rm \
  -e http_proxy="${http_proxy}" -e https_proxy="${https_proxy}" -e no_proxy="${no_proxy}" \
  --mount type=tmpfs,destination=/root/.ansible/cps \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v $(pwd)/lib/releases:/simple-kube/lib/releases \
  -v $(pwd)/lib/inventory:/simple-kube/lib/inventory \
  -v $(pwd)/lib/on-prem-cache:/simple-kube/lib/on-prem-cache \
  kitt0hsu/simple-kube:7c82cf37e6982c1fb90d9b58cae88b4e3b1148b6-20200119180201
