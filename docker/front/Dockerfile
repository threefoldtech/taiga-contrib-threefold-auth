ARG TAIGA_VERSION=latest
ARG RELEASE=main

FROM taigaio/taiga-front:${TAIGA_VERSION}
RUN apk --update add git && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*
    
RUN git clone https://github.com/threefoldtech/taiga-contrib-threefold-auth && cd taiga-contrib-threefold-auth && git checkout ${RELEASE}
RUN mkdir -p /usr/share/nginx/html/plugins/threefold-auth && cp -r taiga-contrib-threefold-auth/front/dist/* /usr/share/nginx/html/plugins/threefold-auth

COPY conf.json.template /usr/share/nginx/html/conf.json.template
COPY 30_config_env_subst.sh /docker-entrypoint.d/30_config_env_subst.sh
RUN chmod +x /docker-entrypoint.d/30_config_env_subst.sh

ENV PUBLIC_REGISTER_ENABLED=false
# change this key. check the documentation for more info.
ENV THREEFOLD_API_APP_PUBLIC_KEY="K4nQYVJJrcV0Y/6QuqeM3FKPGffdKC5/3HpOa/BmewY="
# optional env settings. If these are not set, then hardcoded values are used
ENV THREEFOLD_APP_ID=""
ENV THREEFOLD_URL=""
