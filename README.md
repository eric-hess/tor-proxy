# A simple tor proxy

## Quick Start

### Docker

```bash
docker run -it --rm \
    --publish 8118:8118 \
    --publish 9050:9050 \
    --env HTTP_PROXY_ENABLED=true \
    ghcr.io/eric-hess/tor-proxy:latest
```
Now you can send requests through the tor network.
- Check the http proxy: `curl --proxy localhost:8118 https://check.torproject.org/api/ip`
- Check the socks5 proxy: `curl --socks5 localhost:9050 https://check.torproject.org/api/ip`

### Docker Compose
```yml
services:
    tor-proxy:
        image: ghcr.io/eric-hess/tor-proxy:latest
        restart: unless-stopped
        environment:
          - HTTP_PROXY_ENABLED=true
        ports:
            - 8118:8118
            - 9050:9050
```
## Available env variables

| variable name        | default value | description                                          |
|----------------------|---------------|------------------------------------------------------|
| `TOR_PORT`           | `9050`        | defines on which port the socks5 proxy should listen |
| `PRIVOXY_PORT`       | `8118`        | defines on which port the http proxy should listen   |
| `HTTP_PROXY_ENABLED` | `false`       | defines if the http proxy should be started          |