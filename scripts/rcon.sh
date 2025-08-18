#!/bin/bash
set -e

CFG="/hlds/cstrike/autoexec.cfg"
RCON="${RCON:-}"

if grep -q "^[[:space:]]*rcon_password" "$CFG"; then
  if [[ -n "$RCON" ]]; then
    sed -i "s/^[[:space:]]*rcon_password.*/rcon_password \"${RCON}\"/" "$CFG"
    echo "[OK] RCON password updated."
  else
    # sed -i "s/^[[:space:]]*rcon_password.*/rcon_password \"\"/" "$CFG"
    sed -i '/^[[:space:]]*rcon_password/d' "$CFG"
    echo "[INFO] RCON password cleared"
  fi
elif ! grep -q "^[[:space:]]*rcon_password" "$CFG"; then
  if [[ -n "$RCON" ]]; then
    echo "rcon_password \"${RCON}\"" >> "$CFG"
    echo "[SUCCESS] RCON password added."
  fi
fi
