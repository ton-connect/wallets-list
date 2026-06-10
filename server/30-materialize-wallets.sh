#!/bin/sh
# Materialize wallets-v2.json for this deployment's host. Runs via /docker-entrypoint.d
# before nginx starts listening, so the file is always present for the first request.
set -eu
sed "s|__SERVER_NAME__|${SERVER_NAME}|g" \
    /etc/wallets-list/wallets-v2.json.tpl > /usr/share/nginx/html/wallets-v2.json
