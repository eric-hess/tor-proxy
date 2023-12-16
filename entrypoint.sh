#!/bin/sh

if [ -z "$TOR_PORT" ]; then
  TOR_PORT=9050
fi

if [ -z "$PRIVOXY_PORT" ]; then
  PRIVOXY_PORT=8118
fi

if [ -z "$HTTP_PROXY_ENABLED" ]; then
  HTTP_PROXY_ENABLED="false"
fi

sed -i "s/SocksPort.*/SocksPort 0.0.0.0:${TOR_PORT}/" /etc/tor/torrc
sed -i "s/forward-socks5t.*/forward-socks5t \/ 127.0.0.1:${TOR_PORT} ./" /etc/privoxy/config
sed -i "s/listen-address.*/listen-address 0.0.0.0:${PRIVOXY_PORT}/" /etc/privoxy/config

echo "socks port: ${TOR_PORT}"

if [ "$HTTP_PROXY_ENABLED" = "true" ]; then
  echo "http port: ${PRIVOXY_PORT}"
fi

exec "$@"