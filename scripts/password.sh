#!/bin/bash
set -e

CFG="/hlds/cstrike/autoexec.cfg"
PASSWORD="${PASSWORD:-}"

if grep -q "^[[:space:]]*sv_password" "$CFG"; then
  if [[ -n "$PASSWORD" ]]; then
    sed -i "s/^[[:space:]]*sv_password.*/sv_password \"${PASSWORD}\"/" "$CFG"
    echo "[OK] Server password updated."
  else
    # sed -i "s/^[[:space:]]*sv_password.*/sv_password \"\"/" "$CFG"
    sed -i '/^[[:space:]]*sv_password/d' "$CFG"
    echo "[INFO] Server password cleared."
  fi
elif ! grep -q "^[[:space:]]*sv_password" "$CFG"; then
  if [[ -n "$PASSWORD" ]]; then
    echo "sv_password \"${PASSWORD}\"" >> "$CFG"
    echo "[SUCCESS] Server password added."
  fi
fi
