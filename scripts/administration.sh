#!/bin/bash
set -e

CFG="/hlds/cstrike/autoexec.cfg"
USERS_INI="/hlds/cstrike/addons/amxmodx/configs/users.ini"

PASSWORD="${PASSWORD:-}"
RCON="${RCON:-}"
STEAM_ID="${STEAM_ID:-}"

# Set Hostname
FALLBACK_USED=false
if [[ -z "${HOSTNAME// }" ]]; then
  HOSTNAME="ttKirby's Counter-Strike 1.6 Server"
  FALLBACK_USED=true
  echo "[INFO] HOSTNAME was not set. Using fallback: \"$HOSTNAME\""
fi

if [[ -f "$CFG" && "$FALLBACK_USED" == false ]]; then
  CURRENT=$(grep -E '^\s*hostname\s+"[^"]+"' "$CFG" | sed -E 's/.*"([^"]+)".*/\1/')
  if [[ "$CURRENT" == "$HOSTNAME" ]]; then
    echo "[OK] Hostname is already set to \"$HOSTNAME\""
  elif grep -qE '^\s*hostname\s+"[^"]+"' "$CFG"; then
    sed -i -E "s/^\s*hostname\s+\"[^\"]+\"/hostname \"$HOSTNAME\"/" "$CFG"
    echo "[SUCCESS] Hostname updated to \"$HOSTNAME\""
  else
    echo "hostname \"$HOSTNAME\"" >> "$CFG"
    echo "[SUCCESS] Hostname added to config."
  fi
fi

# Add, change or clear password
if grep -q "^[[:space:]]*sv_password" "$CFG"; then
  if [[ -n "$PASSWORD" ]]; then
    echo "[OK] Server password is being updated."
    sed -i "s/^[[:space:]]*sv_password.*/sv_password \"${PASSWORD}\"/" "$CFG"
  else
    echo "[INFO] Server password is being cleared."
    sed -i "s/^[[:space:]]*sv_password.*/sv_password \"\"/" "$CFG"
  fi
else
  echo "[SUCCESS] Server password is being added."
  echo "sv_password \"${PASSWORD}\"" >> "$CFG"
fi

# Add, change or clear RCON password
if grep -q "^[[:space:]]*rcon_password" "$CFG"; then
  if [[ -n "$RCON" ]]; then
    echo "[OK] RCON password is being updated."
    sed -i "s/^[[:space:]]*rcon_password.*/rcon_password \"${RCON}\"/" "$CFG"
  else
    echo "[INFO] RCON password is being cleared"
    sed -i "s/^[[:space:]]*rcon_password.*/rcon_password \"\"/" "$CFG"
  fi
else
  echo "[SUCCESS] RCON password is being added."
  echo "rcon_password \"${RCON}\"" >> "$CFG"
fi

# Add, change and clear STEAM ID
if [[ -z "$STEAM_ID" && "$AMXMODX" == "true" ]]; then
  sed -i '/## CUSTOM/,$d' "$USERS_INI"
  echo "[INFO] Steam ID's removed."
elif ! grep -Fq "\"$STEAM_ID\"" "$USERS_INI"; then
  if ! grep -Fq "## CUSTOM" "$USERS_INI"; then
    echo "## CUSTOM" >> "$USERS_INI"
  fi
  echo "\"$STEAM_ID\" \"\" \"abcdefghijklmnopqrstu\" \"ce\"" >> "$USERS_INI"
  echo "[SUCCESS] Steam ID has been successfully registered."
else
  echo "[OK] Steam ID is already registered."
fi
