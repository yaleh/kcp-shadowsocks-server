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
RUN wget --no-check-certificate -O docker.tgz https://download.docker.com/linux/static/stable/aarch64/docker-20.10.12.tgz && \
	tar xvfz docker.tgz && \
	cp docker/docker /usr/local/bin && \
	rm -rf docker.tgz docker

# Install kcptun
RUN wget -O /root/kcptun-linux-arm64.tar.gz https://github.com/xtaci/kcptun/releases/download/v20210922/kcptun-linux-arm64-20210922.tar.gz && \
	mkdir -p /opt/kcptun && cd /opt/kcptun && tar xvfz /root/kcptun-linux-arm64.tar.gz && \
	rm -rf /root/shadowsocks-libev /root/kcptun-linux-arm64.tar.gz

COPY service /etc/service
COPY kcp_ss_lib bootstrap show runit_bootstrap /usr/local/bin/

ENV SS_METHOD=aes-256-gcm \
	KCPTUN_CRYPT=aes KCPTUN_MTU=1350 KCPTUN_MODE=normal \
	KCPTUN_SNDWND=4096 KCPTUN_CLIENT_SNDWND=1024 KCPTUN_RCVWND=8192 \
	KCPTUN_DATASHARD=35 KCPTUN_PARITYSHARD=15

EXPOSE 41111/udp 8338

CMD ["/usr/local/bin/runit_bootstrap"]
