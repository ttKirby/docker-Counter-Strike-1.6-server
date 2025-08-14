#!/bin/bash
set -e

CFG="/hlds/cstrike/autoexec.cfg"

# Prüfen, ob alle Einträge vorhanden und korrekt sind
if grep -Eq '^[[:space:]]*sv_allowdownload[[:space:]]*1' "$CFG" && \
   grep -Eq '^[[:space:]]*sv_allowupload[[:space:]]*1' "$CFG" && \
   grep -Eq '^[[:space:]]*sv_downloadurl[[:space:]]*"http://localhost/cstrike"' "$CFG"; then

  echo "[OK] FAST DL is already configured."

else
  echo "[INFO] Configure FAST DOWNLOAD..."

  echo 'sv_allowdownload 1' >> "$CFG"
  echo 'sv_allowupload 1' >> "$CFG"
  echo 'sv_downloadurl "http://localhost/cstrike"' >> "$CFG"

  echo "[SUCCESS] FAST DOWNLOAD successfully configured."
fi
