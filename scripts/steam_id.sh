#!/bin/bash
set -e

USERS_INI="/hlds/cstrike/addons/amxmodx/configs/users.ini"
STEAM_ID="${STEAM_ID:-}"

if [[ -n "$STEAM_ID" && "$METAMOD" != "true" && "$AMXMODX" != "true" ]]; then
  echo "[SKIP] STEAM_ID can only be used when METAMOD and AMXMODX is set to true."

elif [[ -n "$STEAM_ID" && "$METAMOD" == "true" && "$AMXMODX" == "true" ]]; then
  if ! grep -Fq "## CUSTOM" "$USERS_INI"; then
    echo "## CUSTOM" >> "$USERS_INI"
    echo "\"$STEAM_ID\" \"\" \"abcdefghijklmnopqrstu\" \"ce\"" >> "$USERS_INI"
    echo "[SUCCESS] Steam ID has been successfully registered."
  elif grep -A 1000 "## CUSTOM" "$USERS_INI" | grep -Fq "\"$STEAM_ID\""; then
    echo "[OK] Steam ID already registered."
  elif ! grep -A 1000 "## CUSTOM" "$USERS_INI" | grep -Fq "\"$STEAM_ID\""; then
    echo "\"$STEAM_ID\" \"\" \"abcdefghijklmnopqrstu\" \"ce\"" >> "$USERS_INI"
    echo "[SUCCESS] New Steam ID has been successfully registered."
  fi
elif [[ -z "$STEAM_ID" ]]; then
  if grep -Fq "## CUSTOM" "$USERS_INI"; then
    sed -i '/## CUSTOM/,$d' "$USERS_INI"
    echo "[INFO] Steam ID's removed."
  fi
fi
