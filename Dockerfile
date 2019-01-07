# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Yale Huang
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM alpine:edge

LABEL maintainer="Yale Huang <calvino.huang@gmail.com>"

# Build arguments
ARG BUILD_DATE
ARG VCS_REF
ARG NAME

# Basic build-time metadata as defined at http://label-schema.org
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="MIT" \
      org.label-schema.name=$NAME \
      org.label-schema.url="https://github.com/yaleh/kcp-shadowsocks-server" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/yaleh/kcp-shadowsocks-server.git" \
      org.label-schema.vcs-type="Git"

RUN apk --no-cache add --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
	net-tools pwgen bash runit \
	shadowsocks-libev

# Install additional apckages
RUN wget --no-check-certificate https://download.docker.com/linux/static/stable/x86_64/docker-17.12.1-ce.tgz && \
	tar xvfz docker-17.12.1-ce.tgz && \
	cp docker/docker /usr/local/bin && \
	rm -rf docker-17.12.1-ce.tgz docker

# Install kcptun
RUN wget -O /root/kcptun-linux-amd64.tar.gz https://github.com/xtaci/kcptun/releases/download/v20171201/kcptun-linux-amd64-20171201.tar.gz && \
	mkdir -p /opt/kcptun && cd /opt/kcptun && tar xvfz /root/kcptun-linux-amd64.tar.gz && \
	rm -rf /root/shadowsocks-libev /root/kcptun-linux-amd64.tar.gz

COPY service /etc/service
COPY kcp_ss_lib bootstrap show runit_bootstrap /usr/local/bin/

ENV SS_PASSWORD=1234567 SS_METHOD=aes-256-cfb \
	KCPTUN_CRYPT=aes \
	KCPTUN_PASSWORD=1234567 KCPTUN_MTU=1350 \
	KCPTUN_SNDWND=128 KCPTUN_RCVWND=1024 KCPTUN_MODE=fast

EXPOSE 41111/udp 8338

CMD ["/usr/local/bin/runit_bootstrap"]
