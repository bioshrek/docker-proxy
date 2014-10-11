# flannel: build
#

FROM google/debian:wheezy
MAINTAINER Huan Wang <shrekwang1@gmail.com>

RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl build-essential ca-certificates git mercurial bzr
RUN mkdir /goroot && curl https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz | tar xvzf - -C /goroot --strip-components=1
RUN mkdir /gopath

ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN go get -u github.com/gpmgo/gopm

WORKDIR /gopath/src/
RUN git clone https://github.com/dockboard/docker-proxy.git github.com/dockerboard/docker-proxy
WORKDIR /gopath/src/github.com/dockerboard/docker-proxy

RUN gopm build -v
RUN mkdir -p /docker_proxy-binaries/
VOLUME /docker_proxy-binaries

