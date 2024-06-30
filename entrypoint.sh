#!/bin/bash

set -e

if [[ -z $PROXY_PORT ]]; then
	echo "enviroment param PROXY_PORT is needed!"
	exit 1
fi
sed -i "s/<PROXY_PORT>/${PROXY_PORT}/g" /privoxy.conf

if [[ ! $SOCKS_HOST ]]; then
	SOCKS_HOST=127.0.0.1
fi
sed -i "s/<SOCKS_HOST>/${SOCKS_HOST}/g" /privoxy.conf

if [[ ! $SOCKS_PORT ]]; then
	SOCKS_PORT=1080
fi
sed -i "s/<SOCKS_PORT>/${SOCKS_PORT}/g" /privoxy.conf

ssh -gNTC -D ${SOCKS_PORT} -i ${SSH_KEY} \
    -o 'UserKnownHostsFile=/dev/null' -o 'StrictHostKeyChecking=no' \
	-o 'ServerAliveInterval=300' -o 'ExitOnForwardFailure=yes' $SSH_DEST &
privoxy --no-daemon /privoxy.conf
