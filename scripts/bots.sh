#!/bin/bash
set -e

PODBot_URL="https://github.com/APGRoboCop/podbot_mm/releases/download/V3B24-APG/podbot_full_V3B24.zip"
PODBot_SO="linux addons/podbot/podbot_mm_i386.so"
YaPB_URL="https://github.com/yapb/yapb/releases/download/4.4.957/yapb-4.4.957-linux.tar.xz"
YaPB_SO="linux addons/yapb/bin/yapb.so"
ZBot_URL=""
ZBot_SO=""
PLUGINS_INI="/hlds/cstrike/addons/metamod/plugins.ini"

if [[ -z "$BOTS" ]]; then
  sed -i '/^linux addons\/podbot\/podbot_mm_i386\.so$/d' "$PLUGINS_INI"
  sed -i '/^linux addons\/yapb\/bin\/yapb\.so$/d' "$PLUGINS_INI"
  rm -rf /hlds/cstrike/addons/podbot
  rm -rf /hlds/cstrike/addons/yapb
  echo "[INFO] All bots and configurations have been removed."
fi

if [[ "$BOTS" == "PODBot" ]]; then
  if [[ -d "/hlds/cstrike/addons/podbot" && $(grep -Fx "$PODBot_SO" "$PLUGINS_INI") ]]; then
    echo "[OK] PODBot MM is already installed."
  else
    sed -i '/^linux addons\/yapb\/bin\/yapb\.so$/d' "$PLUGINS_INI"
    echo "[INFO] Downloading PODBot V3B24..."
    wget -q "$PODBot_URL" -O podbotmm.zip
    unzip -q podbotmm.zip -d "/hlds/cstrike/addons"
    echo "$PODBot_SO" >> "$PLUGINS_INI"
  fi

elif [[ "$BOTS" == "YaPB" ]]; then
  if [[ -d "/hlds/cstrike/addons/yapb" && $(grep -Fx "$YaPB_SO" "$PLUGINS_INI") ]]; then
    echo "[OK] YaPB is already installed."
  else
    sed -i '/^linux addons\/podbot\/podbot_mm_i386\.so$/d' "$PLUGINS_INI"
    echo "[INFO] Downloading YaPB 4.4.957 package..."
    wget -qO- "$YaPB_URL" | tar -Jxf - -C /hlds/cstrike
    echo "$YaPB_SO" >> "$PLUGINS_INI"
    echo "[SUCCESS] YaPB 4.4.957 installed and registered successfully."
  fi

elif [[ "$BOTS" == "ZBot" ]]; then
    echo "[INFO] Downloading..."
else
  echo "[INFO] No bot installed"
fi
