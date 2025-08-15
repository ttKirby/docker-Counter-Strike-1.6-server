#!/bin/bash
set -e

KEY="${KEY:-}"
PW="${PW:-}"

YAPB_CFG="/hlds/cstrike/addons/yapb/conf/yapb.cfg"

if [[ -z "$KEY" && -z "$PW" ]]; then
  sed -i '/### CUSTOM/,+2d' "$YAPB_CFG"
  echo "[INFO] YaPB configuration removed."
  exit 0
fi

CURRENT_PW=$(sed -n '/### CUSTOM/,+2p' "$YAPB_CFG" | grep '^yb_password ' | sed 's/yb_password "\(.*\)"/\1/')
CURRENT_KEY=$(sed -n '/### CUSTOM/,+2p' "$YAPB_CFG" | grep '^yb_password_key ' | sed 's/yb_password_key "\(.*\)"/\1/')

if [[ "$CURRENT_PW" == "$PW" && "$CURRENT_KEY" == "$KEY" ]]; then
  echo "[OK] YaPB settings already up-to-date."
  exit 0
fi

sed -i '/### CUSTOM/,+2d' "$YAPB_CFG"

{
  echo "### CUSTOM"
  echo "yb_password \"$PW\""
  echo "yb_password_key \"$KEY\""
} >> "$YAPB_CFG"

echo "[SUCCESS] YaPB configuration successfully updated."
