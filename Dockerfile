FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive \
    HLDS_GAME=cstrike \
    HLDS_PORT=27015 \
    HLDS_MAXPLAYERS=16 \
    HLDS_MAP=de_dust2 \
    HLDS_LAN=0 \
    HLDS_IP=0.0.0.0

# Installiert Bibliotheken und andere Services die (vermutlich) benötigt werden
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y \
    lib32gcc-s1 \
    libstdc++6:i386 \
    libcurl4-gnutls-dev:i386 \
    lib32z1 \
    libncurses5:i386 \
    wget \
    unzip \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /steamcmd
RUN mkdir -p /hlds

# Downloaden und entpacken von SteamCMD
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

# Installion des CS 1.6-Servers
RUN ./steamcmd.sh +login anonymous \
    +force_install_dir /hlds \
    +app_update 90 validate \
    +quit

# Metamod 1.20 installieren und einbinden
RUN mkdir -p /tmp/metamod /hlds/cstrike/addons/metamod/dlls && \
    wget -O /tmp/metamod/metamod.tar.gz "https://altushost-bul.dl.sourceforge.net/project/metamod/Metamod%20Binaries/1.20/metamod-1.20-linux.tar.gz" && \
    tar -xzf /tmp/metamod/metamod.tar.gz -C /tmp/metamod && \
    cp /tmp/metamod/metamod_i386.so /hlds/cstrike/addons/metamod/dlls/metamod.so && \
    sed -i 's|gamedll_linux ".*"|gamedll_linux "addons/metamod/dlls/metamod.so"|' /hlds/cstrike/liblist.gam && \
    echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" > /hlds/cstrike/addons/metamod/plugins.ini && \
    rm -rf /tmp/metamod

# # AMX Mod X 1.10.0 herunterladen und installieren
RUN mkdir -p /tmp/amxmodx && \
    wget -O /tmp/amxmodx/amxx.tar.gz "https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5463-base-linux.tar.gz" && \
    tar -xzf /tmp/amxmodx/amxx.tar.gz -C /tmp/amxmodx && \
    cp -r /tmp/amxmodx/addons /hlds/cstrike/ && \
    rm -rf /tmp/amxmodx

# Kopieren von steamclient.so
RUN mkdir -p /root/.steam/sdk32 && \
    cp /hlds/steamclient.so /root/.steam/sdk32/

# Entfernt nicht mehr benötigte Pakete und Dateien
RUN apt-get purge --auto-remove -y wget unzip && \
    rm -rf /hlds/steamapps && \
    rm -rf /hlds/*.log /hlds/*.mdmp /hlds/debug.log && \
    rm -rf /steamcmd /tmp/* /var/tmp/* && \
    apt-get autoremove -y && \
    apt-get clean

WORKDIR /hlds

# Server-Konfigurationen
VOLUME ["/hlds/cstrike/server.cfg"]
VOLUME ["/hlds/cstrike/mapcycle.txt"]

# Metamod & AMX Mod X
VOLUME ["/hlds/cstrike/addons/metamod/plugins.ini"]
VOLUME ["/hlds/cstrike/addons/amxmodx/configs"]
VOLUME ["/hlds/cstrike/addons/amxmodx/plugins"]
VOLUME ["/hlds/cstrike/addons/amxmodx/scripting"]
VOLUME ["/hlds/cstrike/addons/amxmodx/logs"]
VOLUME ["/hlds/cstrike/addons"]

# Maps & Bans
VOLUME ["/hlds/cstrike/maps"]
VOLUME ["/hlds/cstrike/maps/de_dust2_load.cfg"]
VOLUME ["/hlds/cstrike/banned.cfg"]
VOLUME ["/hlds/cstrike/listip.cfg"]

# Notwendige Ports freigeben
EXPOSE 27015/udp 27015

# Starten des Servers
CMD ["sh", "-c", "./hlds_run -game $HLDS_GAME +ip $HLDS_IP +port $HLDS_PORT +map $HLDS_MAP +maxplayers $HLDS_MAXPLAYERS +sv_lan $HLDS_LAN"]
