FROM debian:bookworm-slim

LABEL maintainer="trolltrollKirby"

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    lib32gcc-s1 \
    libstdc++6:i386 \
    libcurl4-gnutls-dev:i386 \
    lib32z1 \
    libncurses5:i386 \
    wget unzip xz-utils \
    ca-certificates \
    nginx \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /steamcmd

COPY /scripts/entrypoint.sh /scripts/entrypoint.sh
COPY /scripts/cstrike.sh /scripts/cstrike.sh
COPY /scripts/metamod.sh /scripts/metamod.sh
COPY /scripts/amxmodx.sh /scripts/amxmodx.sh
COPY /scripts/bots.sh /scripts/bots.sh
COPY /scripts/fastdl.sh /scripts/fastdl.sh
COPY /scripts/rehlds.sh /scripts/rehlds.sh
COPY /scripts/administration.sh /scripts/administration.sh
COPY /nginx.conf /etc/nginx/sites-available/default
RUN chmod -R +x /scripts

EXPOSE 27015/udp 27015

ENTRYPOINT ["/scripts/entrypoint.sh"]
