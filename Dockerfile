FROM alpine:3.19

RUN apk update && \
    apk add --no-cache tor privoxy supervisor

RUN echo "SocksPort 0.0.0.0:9050" >> /etc/tor/torrc

RUN echo "listen-address 0.0.0.0:8118" >> /etc/privoxy/config && \
    echo "forward-socks5t / 127.0.0.1:9050 ." >> /etc/privoxy/config

COPY supervisord.conf /etc/supervisord.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
