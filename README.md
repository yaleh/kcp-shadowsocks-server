# kcp-shadowsocks-server

## Example

```bash
docker run -d --restart=always -e 'SS_PASSWORD=SHADOWSOCKS_PASSWORD' -e 'KCPTUN_PASSWORD=balancing' -p 8338:8338/tcp -p 41111:41111/udp --name=my-kcp-ss yaleh/kcp-shadowsocks-server
```

* SS_PASSWORD: password for Shadowsocks
* KCPTUN_PASSWORD: password for kcptun
* TCP port mapping for 8338: optional, in case to export a Shadowsocks port without FinalSpeed
* UDP port mapping for 41111: required for kcptun

