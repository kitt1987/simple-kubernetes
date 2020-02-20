FROM alpine:3.8 as docker-cli
ARG DOCKER_CLI_VERSION="18.09.7"
ENV DOWNLOAD_URL="https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_CLI_VERSION.tgz"

RUN apk --update add curl \
    && mkdir -p /tmp/download \
    && curl -L $DOWNLOAD_URL | tar -xz -C /tmp/download \
    && mv /tmp/download/docker/docker /usr/local/bin/ \
    && rm -rf /tmp/download \
    && apk del curl \
    && rm -rf /var/cache/apk/*

FROM williamyeh/ansible:alpine3
COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/
RUN apk add --update --no-cache bash && rm -rf /var/cache/apk/*
RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
RUN pip install netaddr
ADD .inputrc /etc/inputrc

WORKDIR /simple-kube
ARG BUILD
LABEL VERSION $BUILD
COPY . /simple-kube/
CMD ["bash"]