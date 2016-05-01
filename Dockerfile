# This dockerfile uses the ubuntu image
# VERSION 1 - EDITION 1
# Author: Yale Huang
# Command format: Instruction [arguments / command] ..

# Base image to use, this must be set as the first line
FROM ubuntu

MAINTAINER Yale Huang <calvino.huang@gmail.com>

# Commands to update the image
RUN apt-get -y update && apt-get -y upgrade

# Install shadowsocks-libev
RUN apt-get install build-essential autoconf libtool libssl-dev git openjdk-7-jre unzip \
	libpcap-dev wget supervisor -y
RUN git clone https://github.com/shadowsocks/shadowsocks-libev.git /root/shadowsocks-libev
RUN wget -O /root/kcptun-linux-amd64.tar.gz https://github.com/xtaci/kcptun/releases/download/v2.18/kcptun-linux-amd64.tar.gz
RUN cd /root/shadowsocks-libev && git checkout v2.4.4 && ./configure && make
RUN cd /root/shadowsocks-libev/src && install -c ss-server /usr/bin
RUN apt-get purge git build-essential autoconf libtool libssl-dev -y  && apt-get autoremove -y && apt-get autoclean -y
RUN mkdir -p /opt/kcptun && cd /opt/kcptun && tar xvfz /root/kcptun-linux-amd64.tar.gz
RUN rm -rf /root/shadowsocks-libev
COPY supervisord.conf /etc/supervisord.conf

ENV SS_PASSWORD 1234567
ENV SS_METHOD aes-256-cfb
ENV KCPTUN_PASSWORD 1234567

EXPOSE 41111/udp 8338/tcp

#ENTRYPOINT /usr/bin/ss-server -s 0.0.0.0 -p 8338 -k ${SS_PASSWORD} -m ${SS_METHOD}
CMD ["/usr/bin/supervisord"]

