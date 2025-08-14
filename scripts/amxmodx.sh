#!/bin/bash
set -e

if [[ -f /hlds/cstrike/addons/amxmodx/dlls/amxmodx_mm_i386.so ]] && \
   [[ -f /hlds/cstrike/addons/amxmodx/plugins/admin.amxx ]] && \
   [[ -f /hlds/cstrike/addons/amxmodx/configs/core.ini ]]; then
  echo "[OK] AmxModX is already installed."

else
  # echo "[INFO] Installing AMX Mod X 1.8.2..."

  # wget -qO- "https://www.amxmodx.org/release/amxmodx-1.8.2-base-linux.tar.gz" | tar -zxf - -C /hlds/cstrike
  # wget -qO- "https://www.amxmodx.org/release/amxmodx-1.8.2-cstrike-linux.tar.gz" | tar -zxf - -C /hlds/cstrike
  # echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" >> /hlds/cstrike/addons/metamod/plugins.ini

  # echo "[INFO] Installing AMX Mod X 1.9.0..."

  # wget -qO- "https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-base-linux.tar.gz" | tar -zxf - -C /hlds/cstrike
  # wget -qO- "https://www.amxmodx.org/amxxdrop/1.9/amxmodx-1.9.0-git5294-cstrike-linux.tar.gz" | tar -zxf - -C /hlds/cstrike
  # echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" >> /hlds/cstrike/addons/metamod/plugins.ini

  echo "[INFO] Installing AMX Mod X 1.10.0..."

  wget -qO- "https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5467-base-linux.tar.gz" | tar -zxf - -C /hlds/cstrike
  wget -qO- "https://www.amxmodx.org/amxxdrop/1.10/amxmodx-1.10.0-git5467-cstrike-linux.tar.gz" | tar -zxf - -C /hlds/cstrike
  echo "linux addons/amxmodx/dlls/amxmodx_mm_i386.so" >> /hlds/cstrike/addons/metamod/plugins.ini

  echo "[SUCCESS] AMX Mod X installation complete."
fi
