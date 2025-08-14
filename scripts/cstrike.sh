#!/bin/bash
set -e

if [[ -f "/hlds/hlds_linux" ]]; then
  echo "[OK] Server is already installed."

else
  echo "[INFO] Download SteamCMD and extract..."

  wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -xz

  echo "[INFO] Installing CS 1.6 Dedicated Server..."
  ./steamcmd.sh \
      +force_install_dir /hlds \
      +login anonymous \
      +app_update 90 validate \
      +quit

  mkdir -p "$HOME/.steam/sdk32"
  cp /hlds/steamclient.so "$HOME/.steam/sdk32/"

  echo "exec autoexec.cfg" >> /hlds/cstrike/server.cfg
  touch /hlds/cstrike/autoexec.cfg

  echo "[SUCCESS] Server installation complete."
fi
