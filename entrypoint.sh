#!/bin/bash

set -e

if [[ -z $PROXY_PORT ]]; then
	echo "enviroment param PROXY_PORT is needed!"
	exit 1
fi
sed -i "s/<PROXY_PORT>/${PROXY_PORT}/g" /privoxy.conf

if [[ ! $SOCKS_HOST ]]; then
	sed -i "s/<SOCKS_HOST>/127.0.0.1/g" /privoxy.conf
else
	sed -i "s/<SOCKS_HOST>/${SOCKS_HOST}/g" /privoxy.conf
fi

if [[ ! $SOCKS_PORT ]]; then
	sed -i "s/<SOCKS_PORT>/1080/g" /privoxy.conf
else
    sed -i "s/<SOCKS_PORT>/${SOCKS_PORT}/g" /privoxy.conf
fi

privoxy --no-daemon /privoxy.conf
