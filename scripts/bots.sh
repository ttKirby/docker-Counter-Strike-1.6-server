#!/bin/bash
set -e

if [[ "$BOTS" == "PODBot" ]]; then
  echo "[INFO] Downloading..."

elif [[ "$BOTS" == "YaPB" ]]; then
  if [[ -d "/hlds/cstrike/addons/yapb" ]]; then
    echo "[OK] YaPB is already installed."
  else
    echo "[INFO] Downloading YaPB 4.4.957 package..."
    wget -qO- "https://github.com/yapb/yapb/releases/download/4.4.957/yapb-4.4.957-linux.tar.xz" | tar -Jxf - -C /hlds/cstrike
    echo 'linux addons/yapb/bin/yapb.so' >> /hlds/cstrike/addons/metamod/plugins.ini
    echo "[SUCCESS] YaPB 4.4.957 installed successfully."
  fi

elif [[ "$BOTS" == "ZBot" ]]; then
    echo "[INFO] Downloading..."
else
  echo "[INFO] No bot installed"
fi

# sofern man die bots wechseln will müssen auch die jeweiligen einträge in METAMOD oder so gelöäscht werden. bitte beachten!!!!