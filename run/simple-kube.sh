#!/usr/bin/env bash

[[ "${http_proxy}" == *"127.0.0.1"* ]] && echo "The proxy to 127.0.0.1 in a container will imply to the container itself." && exit 2
[[ "${https_proxy}" == *"127.0.0.1"* ]] && echo "The proxy to 127.0.0.1 in a container will imply to the container itself." && exit 2

docker run --name simple-kube --net=host -ti --rm \
  -e http_proxy="${http_proxy}" -e https_proxy="${https_proxy}" -e no_proxy="${no_proxy}" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  kitt0hsu/simple-kube