#!/bin/bash
set -e

# 1.8.2 / 1.9.0 / 1.10.0
AMX_VERSION=1.10.0

if [[ -f /hlds/cstrike/addons/amxmodx/dlls/amxmodx_mm_i386.so ]] && \
   [[ -f /hlds/cstrike/addons/amxmodx/plugins/admin.amxx ]] && \
   [[ -f /hlds/cstrike/addons/amxmodx/configs/core.ini ]]; then
  echo "[OK] AmxModX is already installed."

else
  if [[ "$AMX_VERSION" == "1.8.2" ]]; then
    echo "[INFO] Installing AMX Mod X 1.8.2..."
    AMXMODX_CSTRIKE_URL="https://www.amxmodx.org/release/amxmodx-1.8.2-cstrike-linux.tar.gz"
    AMXMODX_BASE_URL=https://www.amxmodx.org/release/amxmodx-1.8.2-base-linux.tar.gz
  elif [[ "$AMX_VERSION" == "1.9.0" ]]; then
    echo "[INFO] Installing AMX Mod X 1.9.0..."
    AMXMODX_CSTRIKE_URL="https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-cstrike-linux.tar.gz"
    AMXMODX_BASE_URL=https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-base-linux.tar.gz
  elif [[ "$AMX_VERSION" == "1.10.0" ]]; then
    echo "[INFO] Installing AMX Mod X 1.10.0..."
    AMXMODX_CSTRIKE_URL="https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5467-cstrike-linux.tar.gz"
    AMXMODX_BASE_URL="https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5467-base-linux.tar.gz"
  fi

  wget -qO- "$AMXMODX_BASE_URL" | tar -zxf - -C /hlds/cstrike
  wget -qO- "$AMXMODX_CSTRIKE_URL" | tar -zxf - -C /hlds/cstrike
  echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" >> /hlds/cstrike/addons/metamod/plugins.ini

  echo "[SUCCESS] AMX Mod X installation complete."
fi
