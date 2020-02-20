.PHONY: image

# auto-generated
TAG := $(shell git rev-parse HEAD)-$(shell date +'%Y%m%d%H%M%S')
IMAGE_NAME := kitt0hsu/simple-kube

default: image

image:
	docker build --build-arg BUILD=$(TAG) -t $(IMAGE_NAME):$(TAG) .
	docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest
