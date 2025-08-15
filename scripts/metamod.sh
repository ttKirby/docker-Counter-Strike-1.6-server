#!/bin/bash
set -e

METAMOD_URL="http://prdownloads.sourceforge.net/metamod/metamod-1.20-linux.tar.gz"
# METAMOD_URL="https://www.amxmodx.org/release/metamod-1.21.1-am.zip"

if [[ -f /hlds/cstrike/addons/metamod/dlls/metamod_i386.so ]] && \
   [[ -f /hlds/cstrike/addons/metamod/plugins.ini ]]; then
  echo "[OK] MetaMod is already installed."

else
  echo "[INFO] Installing Metamod 1.20..."

  mkdir -p /hlds/cstrike/addons/metamod/dlls && \
  wget -qO- "$METAMOD_URL" | tar -zxf - -C /hlds/cstrike/addons/metamod/dlls
  touch /hlds/cstrike/addons/metamod/plugins.ini
  sed -i 's/gamedll_linux "dlls\/cs.so"/#gamedll_linux "dlls\/cs.so"\ngamedll_linux "addons\/metamod\/dlls\/metamod.so"/'  /hlds/cstrike/liblist.gam

  # echo "[INFO] Installing Metamod 1.21.1-am..."

  # mkdir -p /hlds/cstrike/addons/metamod/dlls && \
  # wget -qO /tmp/metamod.zip "$METAMOD_URL" && \
  # unzip -o /tmp/metamod.zip -d /hlds/cstrike/addons/metamod/dlls && \
  # rm /tmp/metamod.zip
  # touch /hlds/cstrike/addons/metamod/plugins.ini
  # sed -i 's/gamedll_linux "dlls\/cs.so"/#gamedll_linux "dlls\/cs.so"\ngamedll_linux "addons\/metamod\/dlls\/metamod.so"/'  /hlds/cstrike/liblist.gam

  echo "[SUCCESS] Metamod installation complete."
fi
