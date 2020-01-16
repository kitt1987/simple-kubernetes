#!/usr/bin/env bash

# Mount tmpfs for SSH ControlPath to work around SSH failures on overlay.
# See https://github.com/moby/moby/issues/12080

docker run --name simple-kube --net=host -ti --rm \
  -e http_proxy="${http_proxy}" -e https_proxy="${https_proxy}" -e no_proxy="${no_proxy}" \
  --mount type=tmpfs,destination=/root/.ansible/cps \
  -v /var/run/docker.sock:/var/run/docker.sock \
  kitt0hsu/simple-kube:15415b795e7209af44b884dd44a1781552e77d6f-20200115112833
