#!/bin/bash
set -e

REHLDS_URL="https://github.com/rehlds/ReHLDS/releases/download/3.14.0.857/rehlds-bin-3.14.0.857.zip"

if [[ -f "/hlds/rehlds.txt" ]];then
  echo "[OK] ReHLDS is already isntalled."
elif [[ "$LEGACY" != true && "$REHLDS" == true ]]; then
  echo "[SKIP] REHLDS can only be used when LEGACY is set to true."
elif [[ "$LEGACY" == true && "$REHLDS" == true ]]; then
  echo "[INFO] Downloading ReHLDS 3.14.0.857..."

  wget -q "$REHLDS_URL" -O rehlds.zip
  unzip -q rehlds.zip "bin/linux32/*" -d /tmp/rehlds-temp
  cp -r /tmp/rehlds-temp/bin/linux32/* /hlds/
  # cp /tmp/rehlds-temp/bin/linux32/engine_i486.so /hlds/
  rm -rf /tmp/rehlds-temp rehlds.zip

  touch /hlds/rehlds.txt

  echo "[SUCCESS] ReHLDS installed"
fi
