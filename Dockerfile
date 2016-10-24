FROM alpine:3.4

RUN apk add --no-cache curl

ENV CONSUL_BACKINATOR_VERSION=1.3
ENV CONSUL_BACKINATOR_HASH=8ea624487a86007825884685dbc978ba87f7a448f11d59b9eb29fd5b1b2a0e87
RUN mkdir -p /tmp/consul-backinator && \
    curl -sL https://github.com/myENA/consul-backinator/releases/download/v${CONSUL_BACKINATOR_VERSION}/consul-backinator-${CONSUL_BACKINATOR_VERSION}-amd64-linux.tar.gz > /tmp/consul-backinator/consul-backinator.tar.gz && \
    echo "${CONSUL_BACKINATOR_HASH}  /tmp/consul-backinator/consul-backinator.tar.gz" | sha256sum -c && \
    tar xvzf /tmp/consul-backinator/consul-backinator.tar.gz -C /tmp/consul-backinator && \
    mv /tmp/consul-backinator/consul-backinator-${CONSUL_BACKINATOR_VERSION}-amd64-linux/consul-backinator-${CONSUL_BACKINATOR_VERSION} /usr/local/bin/consul-backinator && \
    chown root:root /usr/local/bin/consul-backinator && \
    rm -rf /tmp/consul-backinator


ENV GOF3R_VERSION=0.5.0
ENV GOF3R_HASH=d88f199d1580d8c8cac26ba39e15dc6e2126d20e56c3894bd37a226e8b3e665c
RUN mkdir -p /tmp/gof3r && \
    curl -sL https://github.com/rlmcpherson/s3gof3r/releases/download/v${GOF3R_VERSION}/gof3r_${GOF3R_VERSION}_linux_amd64.tar.gz > /tmp/gof3r/gof3r.tar.gz &&\
    echo "${GOF3R_HASH}  /tmp/gof3r/gof3r.tar.gz" | sha256sum -c && \
    tar xvzf /tmp/gof3r/gof3r.tar.gz -C /tmp/gof3r && \
    mv /tmp/gof3r/gof3r_${GOF3R_VERSION}_linux_amd64/gof3r /usr/local/bin && \
    rm -rf /tmp/gof3r
