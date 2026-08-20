FROM python:3.11-alpine AS builder

WORKDIR /build

COPY server/nginx.conf /build/nginx.conf
COPY wallets-v2.json /build/wallets-v2.json
COPY wallets.json /build/wallets.json
COPY scripts/proxy_urls.py /build/proxy_urls.py

# The proxied list is generated against a placeholder host; the runtime entrypoint hook
# substitutes the real SERVER_NAME at container start, so one image serves any host.
RUN python proxy_urls.py \
    --input wallets-v2.json \
    --output wallets-v2.proxy.json \
    --base-url "https://__SERVER_NAME__/assets/"

FROM nginx:alpine

RUN rm /usr/share/nginx/html/*

COPY --from=builder /build/nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /build/wallets-v2.proxy.json /etc/wallets-list/wallets-v2.json.tpl
COPY --from=builder /build/wallets.json /usr/share/nginx/html/wallets.json
COPY assets/ /usr/share/nginx/html/assets/
COPY server/30-materialize-wallets.sh /docker-entrypoint.d/30-materialize-wallets.sh

ENV SERVER_NAME=config.ton.org

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
