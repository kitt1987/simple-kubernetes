FROM williamyeh/ansible:alpine3
RUN apk add --update --no-cache bash && rm -rf /var/cache/apk/*
RUN ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
RUN pip install netaddr

WORKDIR /simple-kube
ARG BUILD
LABEL VERSION $BUILD
COPY . /simple-kube/