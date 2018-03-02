# kcp-shadowsocks-server

## Quick Start

``Bootstrap`` will help you setup a worker container, without setting any
parameter manually. Just copy following line to your terminal and execute it:

```bash
docker run -t -i --rm --network=host \
  -v /var/run/docker.sock:/var/run/docker.sock \
  yaleh/kcp-shadowsocks-server:bootstrap bootstrap
```
The worker container will be setup in seconds. Ports and passwords are generated
by ``Bootstrap`` automatically. And you will see the Shadowsocks links:

```
Current container: fec4e0e2b4087aec93315e02a71241188172e7495921c4dc120d91eca84f3b4b
Current image: sha256:3ca91a6d7f0c8d5ada039b9d79dad13e624db480d202a4d42b5eb3914c790ca8
Network interface: wlp58s0
Host name: 192.168.0.175
Exported Shadowsocks port: 15358
Exported KCPTUN port: 14510
Password: wuWail4V

docker run -d --restart=always -e SS_PASSWORD=wuWail4V -e SS_METHOD=aes-256-cfb -e KCPTUN_MODE=normal -e KCPTUN_PASSWORD=wuWail4V -e KCPTUN_SNDWND=256 -e KCPTUN_RCVWND=256 -e SS_LINK=ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:15358#SS%3A192.168.0.175%3A15358 -e KCPTUN_SS_LINK=ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:14510?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DwuWail4V%3Bmtu%3D1350#KCP_SS%3A192.168.0.175%3A15358 -p 15358:8338/tcp -p 14510:41111/udp sha256:3ca91a6d7f0c8d5ada039b9d79dad13e624db480d202a4d42b5eb3914c790ca8

Worker container: 4d658d2be455fd934345d03e30d2136d2fab46eab8bb7d2fc54a9e0e7e5fb7c8

Shadowsocks link: ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:15358#SS%3A192.168.0.175%3A15358
QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A%2F%2FYWVzLTI1Ni1jZmI6d3VXYWlsNFY%3D%40192.168.0.175%3A15358%23SS%253A192.168.0.175%253A15358

KCPTUN SS link: ss://YWVzLTI1Ni1jZmI6d3VXYWlsNFY=@192.168.0.175:14510?plugin=kcptun%3Bmode%3Dnormal%3Brcvwnd%3D256%3Bsndwnd%3D256%3Bkey%3DwuWail4V%3Bmtu%3D1350#KCP_SS%3A192.168.0.175%3A15358
QR code: https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=ss%3A%2F%2FYWVzLTI1Ni1jZmI6d3VXYWlsNFY%3D%40192.168.0.175%3A14510%3Fplugin%3Dkcptun%253Bmode%253Dnormal%253Brcvwnd%253D256%253Bsndwnd%253D256%253Bkey%253DwuWail4V%253Bmtu%253D1350%23KCP_SS%253A192.168.0.175%253A15358
```

Then, just import the above ``ss://`` links to your client to your client. It's done! 

### Optional

To see the passwords and other parameters of Shadowsocks and KCPTUN:

```
docker inspect -f '{{range $_, $e := .Config.Env}}{{println $e}}{{end}}' <WORKDER_CONTAINER_ID>
```

### Notice

* The links of QR code can be opened with your browser. They are QR code images
which can be scanned and imported by Shadowsocks Android client.
* ``Bootstrap`` can be executed for multiple times and you will get multiple running
worker containers.

## Manually

```bash
docker run -d --restart=always -e 'SS_PASSWORD=SHADOWSOCKS_PASSWORD' -e 'KCPTUN_PASSWORD=balancing' -p 8338:8338/tcp -p 41111:41111/udp --name=my-kcp-ss yaleh/kcp-shadowsocks-server
```

* SS_PASSWORD: password for Shadowsocks
* KCPTUN_PASSWORD: password for kcptun
* TCP port mapping for 8338: optional, in case to export a Shadowsocks port without FinalSpeed
* UDP port mapping for 41111: required for kcptun
