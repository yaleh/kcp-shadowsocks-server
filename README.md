# kcp-shadowsocks-server

[![](http://dockeri.co/image/yaleh/kcp-shadowsocks-server)](https://hub.docker.com/r/yaleh/kcp-shadowsocks-server/builds/)

[![Docker Build Status](https://img.shields.io/docker/build/yaleh/kcp-shadowsocks-server.svg)](https://hub.docker.com/r/yaleh/kcp-shadowsocks-server/) [![Docker Automated build](https://img.shields.io/docker/automated/yaleh/kcp-shadowsocks-server.svg)](https://hub.docker.com/r/yaleh/kcp-shadowsocks-server/) [![Docker Stars](https://img.shields.io/docker/stars/yaleh/kcp-shadowsocks-server.svg)](https://hub.docker.com/r/yaleh/kcp-shadowsocks-server/)
[![Docker Pulls](https://img.shields.io/docker/pulls/yaleh/kcp-shadowsocks-server.svg)](https://hub.docker.com/r/yaleh/kcp-shadowsocks-server/) [![GitHub commits](https://img.shields.io/github/commits-since/yaleh/kcp-shadowsocks-server/init.svg)](https://github.com/yaleh/kcp-shadowsocks-server) [![ImageLayers Size](https://img.shields.io/imagelayers/image-size/yaleh/kcp-shadowsocks-server/latest.svg)](https://hub.docker.com/r/yaleh/kcp-shadowsocks-server/) [![ImageLayers Layers](https://img.shields.io/imagelayers/layers/yaleh/kcp-shadowsocks-server/latest.svg)](https://hub.docker.com/r/yaleh/kcp-shadowsocks-server/)

A Docker image of KCPTUN + Shadowsocks, auto-generated parameters and
`ss://` links.

## Quick Start

``Bootstrap`` will help you setup a worker container, without setting any
parameter manually. Just copy following line to your terminal and execute it:

```bash
docker run -t -i --rm --network=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  yaleh/kcp-shadowsocks-server bootstrap
```

The worker container will be setup in seconds. Ports and passwords are generated
by ``Bootstrap`` automatically. And you will see the Shadowsocks links:

```
Current container: 2de5d0362e16ef4b134e471ec9ce7ecf47624496e5d92a4c404aaf669108d2d4
Current image: yaleh/kcp-shadowsocks-server:runit
Network interface: wlp58s0
Host name: 172.18.0.25
Exported Shadowsocks port: 15858
Exported KCPTUN port: 9974
Password: ohHoh4bi

docker run -d --restart=always --name ss-15858-kcp-9974 -e SS_PASSWORD=ohHoh4bi -e SS_METHOD=aes-256-cfb -e KCPTUN_MODE=normal -e KCPTUN_PASSWORD=ohHoh4bi -e KCPTUN_SNDWND=256 -e KCPTUN_RCVWND=256 -e SS_LINK=ss://YWVzLTI1Ni1jZmI6b2hIb2g0YmlAMTcyLjE4LjAuMjU6MTU4NTg=#SS:172.18.0.25:15858 -e KCPTUN_SS_LINK=ss://YWVzLTI1Ni1jZmI6b2hIb2g0Ymk=@172.18.0.25:9974?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DohHoh4bi%3Bmtu%3D1350#KCP_SS%3A172.18.0.25%3A9974 -p 15858:8338/tcp -p 9974:41111/udp yaleh/kcp-shadowsocks-server:runit

Worker container: 29d1d7206b99a809520792382a99ee350b2b8030e4bdf5566577e017e1dd8a5e
Worker container name: ss-15858-kcp-9974

----

Shadowsocks link: ss://YWVzLTI1Ni1jZmI6b2hIb2g0YmlAMTcyLjE4LjAuMjU6MTU4NTg=#SS:172.18.0.25:15858

QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A//YWVzLTI1Ni1jZmI6b2hIb2g0YmlAMTcyLjE4LjAuMjU6MTU4NTg%3D%23SS%3A172.18.0.25%3A15858

----

KCPTUN SS link (for Android client only): ss://YWVzLTI1Ni1jZmI6b2hIb2g0Ymk=@172.18.0.25:9974?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DohHoh4bi%3Bmtu%3D1350#KCP_SS%3A172.18.0.25%3A9974

QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A//YWVzLTI1Ni1jZmI6b2hIb2g0Ymk%3D%40172.18.0.25%3A9974%3Fplugin%3Dkcptun%253Bmode%253Dnormal%253Brcvwnd%253D256%253Bsndwnd%253D256%253Bkey%253DohHoh4bi%253Bmtu%253D1350%23KCP_SS%253A172.18.0.25%253A9974

```

Then, just import the above ``ss://`` links to your client to your client. It's
done!

### Optional

* Show Shadowsocks links and QR codes of a running worker container:

```
$ docker exec -it 4d658d2be455 show
Shadowsocks link: ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:15358#SS%3A192.168.0.175%3A15358
QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A%2F%2FYWVzLTI1Ni1jZmI6d3VXYWlsNFY%3D%40192.168.0.175%3A15358%23SS%253A192.168.0.175%253A15358

KCPTUN SS link: ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:14510?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DwuWail4V%3Bmtu%3D1350#KCP_SS%3A192.168.0.175%3A15358
QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A%2F%2FYWVzLTI1Ni1jZmI6d3VXYWlsNFY%3D%40192.168.0.175%3A14510%3Fplugin%3Dkcptun%253Bmode%253Dnormal%253Brcvwnd%253D256%253Bsndwnd%253D256%253Bkey%253DwuWail4V%253Bmtu%253D1350%23KCP_SS%253A192.168.0.175%253A15358
```

* To see the passwords and other parameters of Shadowsocks and KCPTUN:

```
docker inspect -f '{{range $_, $e := .Config.Env}}{{println $e}}{{end}}' <WORKDER_CONTAINER_ID>
```

### Notice

* The links of QR code can be opened with your browser. They are QR code images
which can be scanned and imported by Shadowsocks Android client.
* ``Bootstrap`` can be executed for multiple times and you will get multiple
running worker containers.

## Manually

```bash
docker run -d --restart=always -e 'SS_PASSWORD=SHADOWSOCKS_PASSWORD' -e 'KCPTUN_PASSWORD=balancing' -p 8338:8338/tcp -p 41111:41111/udp --name=my-kcp-ss yaleh/kcp-shadowsocks-server
```

* SS_PASSWORD: password for Shadowsocks
* KCPTUN_PASSWORD: password for kcptun
* TCP port mapping for 8338: optional, in case to export a Shadowsocks port without FinalSpeed
* UDP port mapping for 41111: required for kcptun
