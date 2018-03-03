# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Yale Huang
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM alpine:edge

MAINTAINER Yale Huang <calvino.huang@gmail.com>

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
	KCPTUN_PASSWORD=1234567 KCPTUN_MTU=1350 \
	KCPTUN_SNDWND=128 KCPTUN_RCVWND=1024 KCPTUN_MODE=fast

EXPOSE 41111/udp 8338/tcp

CMD ["/usr/local/bin/runit_bootstrap"]
