#!/bin/bash
set -e

if [[ -f "/hlds/hlds_linux" ]]; then
  echo "[OK] Server with HLDS is already installed."

else
  if [[ "$REHLDS" == true || "$LEGACY" == true ]]; then
      STEAMCMD="+app_update 90 -beta steam_legacy validate"
      echo "[INFO] Download HLDS Legacy Version (Build 8684)..."
  elif [[ -z "$REHLDS" && -z "$LEGACY" ]]; then
      STEAMCMD="+app_update 90 validate"
      echo "[INFO] Download HLDS 25th Anniversary Edition (Build 10210)..."
  else
      echo "[ERROR] rehlds und legacy beißen sich"
  fi
  wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz

  echo "[INFO] Installing CS 1.6 Dedicated Server..."
  ./steamcmd.sh \
      +force_install_dir /hlds \
      +login anonymous \
      $STEAMCMD \
      +quit

    mkdir -p "$HOME/.steam/sdk32"
    cp /hlds/steamclient.so "$HOME/.steam/sdk32/"

  echo "exec autoexec.cfg" >> /hlds/cstrike/server.cfg
  touch /hlds/cstrike/autoexec.cfg

  echo "[SUCCESS] Server installation complete."
fi
