# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Yale Huang
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu:16.10

MAINTAINER Yale Huang <calvino.huang@gmail.com>

# Commands to update the image
RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install shadowsocks-libev wget supervisor -y && \
    apt-get autoremove -y && apt-get autoclean -y
RUN wget -O /root/kcptun-linux-amd64.tar.gz https://github.com/xtaci/kcptun/releases/download/v20170221/kcptun-linux-amd64-20170221.tar.gz && \
    mkdir -p /opt/kcptun && cd /opt/kcptun && tar xvfz /root/kcptun-linux-amd64.tar.gz && \
    rm -rf /root/shadowsocks-libev
COPY supervisord.conf /etc/supervisord.conf

ENV SS_PASSWORD=1234567 SS_METHOD=aes-256-cfb KCPTUN_PASSWORD=1234567 \
	MTU=1350 SNDWND=128 RCVWND=1024 MODE=fast

EXPOSE 41111/udp 8338/tcp

CMD ["/usr/bin/supervisord"]

