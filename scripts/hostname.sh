#!/bin/bash
set -e

CFG="/hlds/cstrike/autoexec.cfg"

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
