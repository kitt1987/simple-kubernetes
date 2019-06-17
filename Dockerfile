FROM williamyeh/ansible:alpine3
RUN apk add --update --no-cache bash && rm -rf /var/cache/apk/*

WORKDIR /simple-kube
ARG BUILD
LABEL VERSION $BUILD
COPY . /simple-kube/