#!/bin/bash
set -e

KEY="${KEY:-}"
PW="${PW:-}"

PODBOT_CFG="/hlds/cstrike/addons/podbot/podbot.cfg"

if [[ -z "$KEY" && -z "$PW" ]]; then
  sed -i '/### CUSTOM/,+2d' "$PODBOT_CFG"
  echo "[INFO] YaPB configuration removed."
  exit 0
fi

CURRENT_PW=$(sed -n '/### CUSTOM/,+2p' "$PODBOT_CFG" | grep '^pb_password ' | sed 's/pb_password "\(.*\)"/\1/')
CURRENT_KEY=$(sed -n '/### CUSTOM/,+2p' "$PODBOT_CFG" | grep '^pb_password_key ' | sed 's/pb_password_key "\(.*\)"/\1/')

if [[ "$CURRENT_PW" == "$PW" && "$CURRENT_KEY" == "$KEY" ]]; then
  echo "[OK] YaPB settings already up-to-date."
  exit 0
fi

sed -i '/### CUSTOM/,+2d' "$PODBOT_CFG"

{
  echo "### CUSTOM"
  echo "pb_password \"$PW\""
  echo "pb_password_key \"$KEY\""
} >> "$PODBOT_CFG"

echo "[SUCCESS] PODBot configuration successfully updated."
